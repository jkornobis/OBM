package OBM::Entities::obmContact;

$VERSION = '1.0';

use OBM::Entities::entities;
@ISA = ('OBM::Entities::entities');

$debug = 1;

use 5.006_001;
require Exporter;
use strict;

use OBM::Parameters::common;


# Needed
sub new {
    my $class = shift;
    my( $parent, $contactDesc ) = @_;

    my $self = bless { }, $class;

    if( ref($parent) ne 'OBM::Entities::obmDomain' ) {
        $self->_log( 'domaine père incorrect', 1 );
        return undef;
    }
    $self->setParent( $parent );

    if( defined($contactDesc) && $self->_init( $contactDesc ) ) {
        $self->_log( 'problème lors de l\'initialisation du contact', 1 );
        return undef;
    }

    $self->{'objectclass'} = [ 'inetOrgPerson', 'obmContact' ];

    return $self;
}


# Needed
sub DESTROY {
    my $self = shift;

    $self->_log( 'suppression de l\'objet', 5 );

    $self->{'parent'} = undef;
}


# Needed
sub _init {
    my $self = shift;
    my( $contactDesc ) = @_;

    if( !defined($contactDesc) || (ref($contactDesc) ne 'HASH') ) {
        $self->_log( 'description du contact incorrecte', 1 );
        return 1;
    }

    if( $contactDesc->{'contact_firstname'} ) {
        $contactDesc->{'contactCommonName'} = $contactDesc->{'contact_firstname'};
    }

    if( $contactDesc->{'contact_lastname'} ) {
        if( $contactDesc->{'contactCommonName'} ) {
            $contactDesc->{'contactCommonName'} .= ' ';
        }

        $contactDesc->{'contactCommonName'} .= $contactDesc->{'contact_lastname'};
    }

    if( !$contactDesc->{'contactCommonName'} ) {
        $self->_log( 'nom et prénom non renseigné, export LDAP impossible de '.$self->getDescription(), 2 );
        return 1;
    }

    $self->{'entityDesc'} = $contactDesc;

    $self->_log( 'chargement : '.$self->getDescription(), 3 );

    return 0;
}


sub setLinks {
    my $self = shift;
    my( $links ) = @_;

    if( !defined($links) || ref($links) ne 'HASH' ) {
        $self->_log( 'pas de liens définis', 1 );
        return 0;
    }

    $self->_setPhoneLinks( $links->{'phone'} );
    $self->_setAddresses( $links->{'address'} );
    $self->_setEmail( $links->{'email'} );
    $self->_setWebsite( $links->{'website'} );

    return 0;
}


sub _setPhoneLinks {
    my $self = shift;
    my( $phoneLinks ) = @_;
    my $entityDesc = $self->{'entityDesc'};

    for( my $i=0; $i<=$#{$phoneLinks}; $i++ ) {
        my $currentPhone = $phoneLinks->[$i];

        SWITCH: {
            if( $currentPhone->{'phone_label'} =~ /^HOME;VOICE/ ) {
                $entityDesc->{'phones'}->{'homePhone'}->{$currentPhone->{'phone_number'}} = 1;
                last SWITCH;
            }

            if( $currentPhone->{'phone_label'} =~ /^WORK;VOICE/ ) {
                $entityDesc->{'phones'}->{'workPhone'}->{$currentPhone->{'phone_number'}} = 1;
                last SWITCH;
            }

            if( $currentPhone->{'phone_label'} =~ /^WORK;FAX/ ) {
                $entityDesc->{'phones'}->{'workFax'}->{$currentPhone->{'phone_number'}} = 1;
                last SWITCH;
            }

            if( $currentPhone->{'phone_label'} =~ /^CELL;VOICE/ ) {
                $entityDesc->{'phones'}->{'mobilePhone'}->{$currentPhone->{'phone_number'}} = 1;
                last SWITCH;
            }

            if( $currentPhone->{'phone_label'} =~ /^PAGER/ ) {
                $entityDesc->{'phones'}->{'pager'}->{$currentPhone->{'phone_number'}} = 1;
                last SWITCH;
            }
        }
    }

    while( my( $key, $value ) = each(%{$entityDesc->{'phones'}}) ) {
        my @phones = keys(%{$value});
        $entityDesc->{'phones'}->{$key} = \@phones;
    }

    return 0;
}


sub _setAddresses {
    my $self = shift;
    my( $addressLinks ) = @_;
    my $entityDesc = $self->{'entityDesc'};

    for( my $i=0; $i<=$#{$addressLinks}; $i++ ) {
        my $currentAddress = $addressLinks->[$i];

        SWITCH: {
            if( $currentAddress->{'address_label'} =~ /^WORK;X-OBM-Ref1$/ ) {
                if( my $address = $self->_ldapPostalAddressFormatting( $currentAddress ) ) {
                    $entityDesc->{'address'}->{'prefered'} = $self->_ldapPostalAddressFormatting( $currentAddress );
                }
            }

            if( $currentAddress->{'address_label'} =~ /^WORK/ ) {
                if( !defined($entityDesc->{'address'}->{'work'}) ) {
                    if( my $address = $self->_ldapAddressFormatting( $currentAddress ) ) {
                        $entityDesc->{'address'}->{'work'} = $address;
                    }
                }
                last SWITCH;
            }

            if( $currentAddress->{'address_label'} =~ /^HOME/ ) {
                if( my $address = $self->_ldapPostalAddressFormatting( $currentAddress ) ) {
                    $entityDesc->{'address'}->{'home'}->{$address} = 1;
                }
                last SWITCH;
            }
        }
    }

    if( defined($entityDesc->{'address'}->{'home'}) ) {
        my @keys = keys(%{$entityDesc->{'address'}->{'home'}});
        $entityDesc->{'address'}->{'home'} = \@keys;
    }

    return 0;
}


sub _ldapPostalAddressFormatting {
    my $self = shift;
    my( $address ) = @_;
    my @address;

    push( @address, $address->{'address_street'} ) if $address->{'address_street'};
    push( @address, $address->{'address_expresspostal'} ) if $address->{'address_expresspostal'};
    
    my $town = $address->{'address_town'};
    if( $town && $address->{'address_zipcode'} ) {
        $town .= ', ';
    }
    $town .= $address->{'address_zipcode'} if $address->{'address_zipcode'};
    push( @address, $town ) if $town;
    push( @address, $address->{'address_country'} ) if $address->{'address_country'};
    
    return join( '$', @address );
}


sub _ldapAddressFormatting {
    my $self = shift;
    my( $address ) = @_;
    my %formatedAddress;

    $formatedAddress{'street'} = $address->{'address_street'};
    $formatedAddress{'zipcode'} = $address->{'address_zipcode'};
    $formatedAddress{'town'} = $address->{'address_town'};
    $formatedAddress{'cedex'} = $address->{'address_expresspostal'};
    $formatedAddress{'country'} = $address->{'address_country'};
    
    return \%formatedAddress;
}


sub _setEmail {
    my $self = shift;
    my( $emailLinks ) = @_;
    my $entityDesc = $self->{'entityDesc'};

    for( my $i=0; $i<=$#{$emailLinks}; $i++ ) {
        my $currentEmail = $emailLinks->[$i];

        $entityDesc->{'email'}->{$currentEmail->{'email_address'}} = 1;
    }

    if( defined($entityDesc->{'email'}) ) {
        my @emails = keys(%{$entityDesc->{'email'}});
        $entityDesc->{'email'} = \@emails;
    }

    return 0;
}


sub _setWebsite {
    my $self = shift;
    my( $websiteLinks ) = @_;
    my $entityDesc = $self->{'entityDesc'};

    for( my $i=0; $i<=$#{$websiteLinks}; $i++ ) {
        my $currentWebsite = $websiteLinks->[$i];

        $entityDesc->{'website'}->{$currentWebsite->{'website_url'}} = 1;
    }

    if( defined($entityDesc->{'website'}) ) {
        my @website = keys(%{$entityDesc->{'website'}});
        $entityDesc->{'website'} = \@website;
    }

    return 0;
}


# Needed
sub getDescription {
    my $self = shift;
    my $entityDesc = $self->{'entityDesc'};

    my $description = 'contact';

    if( $entityDesc->{'contactCommonName'} ) {
        $description .= ' \''.$entityDesc->{'contactCommonName'}.'\'';
    }

    $description .= ' (ID:'.$entityDesc->{'contact_id'}.')';

    return $description;
}


# Needed
sub getDomainId {
    my $self = shift;

    return $self->{'entityDesc'}->{'contact_domain_id'};
}


# Needed
sub getId {
    my $self = shift;

    return $self->{'entityDesc'}->{'contact_id'};
}


# Needed by : LdapEngine
sub getLdapServerId {
    my $self = shift;

    if( defined($self->{'parent'}) ) {
        return $self->{'parent'}->getLdapServerId();
    }

    return undef;
}


# Needed by : LdapEngine
sub setParent {
    my $self = shift;
    my( $parent ) = @_;

    if( ref($parent) ne 'OBM::Entities::obmDomain' ) {
        $self->_log( 'description du domaine parent incorrecte', 1 );
        return 1;
    }

    $self->{'parent'} = $parent;

    return 0;
}


# Needed by : LdapEngine
sub _getParentDn {
    my $self = shift;
    my $parentDn = undef;

    if( defined($self->{'parent'}) ) {
        $parentDn = $self->{'parent'}->getDnPrefix($self);
    }

    return $parentDn;
}


# Needed by : LdapEngine
sub getDnPrefix {
    my $self = shift;
    my $rootDn;
    my @dnPrefixes;

    if( !($rootDn = $self->_getParentDn()) ) {
        $self->_log( 'DN de la racine du domaine parent non déterminée', 4 );
        return undef;
    }

    for( my $i=0; $i<=$#{$rootDn}; $i++ ) {
        push( @dnPrefixes, 'obmUID='.$self->{'entityDesc'}->{'contactentity_entity_id'}.','.$rootDn->[$i] );
    }

    return \@dnPrefixes;
}


# Needed by : LdapEngine
sub getCurrentDnPrefix {
    my $self = shift;

    return $self->getDnPrefix();
}


sub _getLdapObjectclass {
    my $self = shift;
    my ($objectclass, $deletedObjectclass) = @_;
    my %realObjectClass;

    if( !defined($objectclass) || (ref($objectclass) ne 'ARRAY') ) {
        $objectclass = $self->{'objectclass'};
    }

    for( my $i=0; $i<=$#$objectclass; $i++ ) {
        $realObjectClass{$objectclass->[$i]} = 1;
    }

    my @realObjectClass = keys(%realObjectClass);
    return \@realObjectClass;
}


sub createLdapEntry {
    my $self = shift;
    my ( $entryDn, $entry ) = @_;

    if( !$entryDn ) {
        $self->_log( 'DN non défini', 1 );
        return 1;
    }

    if( ref($entry) ne 'Net::LDAP::Entry' ) {
        $self->_log( 'entrée LDAP incorrecte', 1 );
        return 1;
    }

    $entry->add(
        objectClass => $self->_getLdapObjectclass(),
        cn => $self->{'entityDesc'}->{'contactCommonName'},
        sn => $self->{'entityDesc'}->{'contactCommonName'},
        obmUID => $self->{'entityDesc'}->{'contactentity_entity_id'}
    );


    $self->_modifyAttr( $self->{'parent'}->getDesc('domain_name'), $entry, 'obmDomain' );

    $self->_modifyAttr( $self->{'entityDesc'}->{'contact_firstname'}, $entry, 'givenName' );
    $self->_modifyAttr( $self->{'entityDesc'}->{'contact_lastname'}, $entry, 'sn' );
    $self->_modifyAttr( $self->{'entityDesc'}->{'contact_title'}, $entry, 'title' );
    $self->_modifyAttr( $self->{'entityDesc'}->{'contact_description'}, $entry, 'description' );
    $self->_modifyAttr( $self->{'entityDesc'}->{'contact_service'}, $entry, 'ou' );

    if( $self->{'entityDesc'}->{'company_name'} ) {
        $self->_modifyAttr( $self->{'entityDesc'}->{'company_name'}, $entry, 'o' );
        $self->_modifyAttr( $self->{'entityDesc'}->{'company_name'}, $entry, 'company' );
    }elsif($self->{'entityDesc'}->{'contact_company'}) {
        $self->_modifyAttr( $self->{'entityDesc'}->{'contact_company'}, $entry, 'organizationName' );
        $self->_modifyAttr( $self->{'entityDesc'}->{'contact_company'}, $entry, 'company' );
    }

    $self->_modifyAttr( $self->{'entityDesc'}->{'phones'}->{'homePhone'}, $entry, 'homePhone' );
    $self->_modifyAttr( $self->{'entityDesc'}->{'phones'}->{'workPhone'}, $entry, 'telephoneNumber' );
    $self->_modifyAttr( $self->{'entityDesc'}->{'phones'}->{'workFax'}, $entry, 'facsimileTelephoneNumber' );
    $self->_modifyAttr( $self->{'entityDesc'}->{'phones'}->{'mobilePhone'}, $entry, 'mobile' );
    $self->_modifyAttr( $self->{'entityDesc'}->{'phones'}->{'pager'}, $entry, 'pager' );

    $self->_modifyAttr( $self->{'entityDesc'}->{'address'}->{'home'}, $entry, 'homePostalAddress' );
    # Thunderbird, IceDove... : ne comprennent que cet attribut
    $self->_modifyAttr( $self->{'entityDesc'}->{'address'}->{'work'}->{'street'}, $entry, 'street' );
    # Outlook : ne comprend que cet attribut
    # Outlook Express : préfère celui-là à 'street'
    $self->_modifyAttr( $self->{'entityDesc'}->{'address'}->{'work'}->{'street'}, $entry, 'postalAddress' );
    $self->_modifyAttr( $self->{'entityDesc'}->{'address'}->{'work'}->{'zipcode'}, $entry, 'postalCode' );
    $self->_modifyAttr( $self->{'entityDesc'}->{'address'}->{'work'}->{'town'}, $entry, 'l' );
    $self->_modifyAttr( $self->{'entityDesc'}->{'address'}->{'prefered'}, $entry, 'registeredAddress' );

    $self->_modifyAttr( $self->{'entityDesc'}->{'email'}, $entry, 'mail' );

    $self->_modifyAttr( $self->{'entityDesc'}->{'website'}, $entry, 'URL' );
    $self->_modifyAttr( $self->{'entityDesc'}->{'website'}, $entry, 'workUrl' );


    return 0;
}


sub updateLdapEntry {
    my $self = shift;
    my( $entry, $objectclassDesc ) = @_;
    my $update = 0;

    if( ref($entry) ne 'Net::LDAP::Entry' ) {
        return $update;
    }
    

    # Vérification des objectclass
    my @deletedObjectclass;
    my $currentObjectclass = $self->_getLdapObjectclass( $entry->get_value('objectClass', asref => 1), \@deletedObjectclass);
    if( $self->_modifyAttrList( $currentObjectclass, $entry, 'objectClass' ) ) {
        $update = 1;
    }

    if( $#deletedObjectclass >= 0 ) {
        # Pour les schémas LDAP supprimés, on détermine les attributs à
        # supprimer.
        # Uniquement ceux qui ne sont pas utilisés par d'autres objets.
        my $deleteAttrs = $self->_diffObjectclassAttrs(\@deletedObjectclass, $currentObjectclass, $objectclassDesc);

        for( my $i=0; $i<=$#$deleteAttrs; $i++ ) {
            if( $self->_modifyAttrList( undef, $entry, $deleteAttrs->[$i] ) ) {
                $update = 1;
            }
        }
    }
    

    if( $self->getUpdateEntity() ) {
        if( $self->_modifyAttr( $self->{'parent'}->getDesc('domain_name'), $entry, 'obmDomain' ) ) {
            $update = 1;
        }

        if( $self->_modifyAttr( $self->{'entityDesc'}->{'contact_firstname'}, $entry, 'givenName' ) ) {
            $update = 1;
        }

        if( $self->_modifyAttr( $self->{'entityDesc'}->{'contact_lastname'}, $entry, 'sn' ) ) {
            $update = 1;
        }

        if( $self->_modifyAttr( $self->{'entityDesc'}->{'contact_title'}, $entry, 'title' ) ) {
            $update = 1;
        }
        
        if( $self->_modifyAttr( $self->{'entityDesc'}->{'contact_description'}, $entry, 'description' ) ) {
            $update = 1;
        }
        
        if( $self->_modifyAttr( $self->{'entityDesc'}->{'contact_service'}, $entry, 'ou' ) ) {
            $update = 1;
        }
    
        if( $self->{'entityDesc'}->{'company_name'} ) {
            if( $self->_modifyAttr( $self->{'entityDesc'}->{'company_name'}, $entry, 'o' ) ) {
                $update = 1;
            }

            if( $self->_modifyAttr( $self->{'entityDesc'}->{'company_name'}, $entry, 'company' ) ) {
                $update = 1;
            }
        }elsif($self->{'entityDesc'}->{'contact_company'}) {
            if( $self->_modifyAttr( $self->{'entityDesc'}->{'contact_company'}, $entry, 'o' ) ) {
                $update = 1;
            }

            if( $self->_modifyAttr( $self->{'entityDesc'}->{'contact_company'}, $entry, 'company' ) ) {
                $update = 1;
            }
        }
    
        if( $self->_modifyAttr( $self->{'entityDesc'}->{'phones'}->{'homePhone'}, $entry, 'homePhone' ) ) {
            $update = 1;
        }

        if( $self->_modifyAttr( $self->{'entityDesc'}->{'phones'}->{'workPhone'}, $entry, 'telephoneNumber' ) ) {
            $update = 1;
        }

        if( $self->_modifyAttr( $self->{'entityDesc'}->{'phones'}->{'workFax'}, $entry, 'facsimileTelephoneNumber' ) ) {
            $update = 1;
        }

        if( $self->_modifyAttr( $self->{'entityDesc'}->{'phones'}->{'mobilePhone'}, $entry, 'mobile' ) ) {
            $update = 1;
        }

        if( $self->_modifyAttr( $self->{'entityDesc'}->{'phones'}->{'pager'}, $entry, 'pager' ) ) {
            $update = 1;
        }
    
        if( $self->_modifyAttr( $self->{'entityDesc'}->{'address'}->{'home'}, $entry, 'homePostalAddress' ) ) {
            $update = 1;
        }

        # Thunderbird, IceDove... : ne comprennent que cet attribut
        if( $self->_modifyAttr( $self->{'entityDesc'}->{'address'}->{'work'}->{'street'}, $entry, 'street' ) ) {
            $update = 1;
        }
        # Outlook : ne comprend que cet attribut
        # Outlook Express : préfère celui-là à 'street'
        if( $self->_modifyAttr( $self->{'entityDesc'}->{'address'}->{'work'}->{'street'}, $entry, 'postalAddress' ) ) {
            $update = 1;
        }
        if( $self->_modifyAttr( $self->{'entityDesc'}->{'address'}->{'work'}->{'zipcode'}, $entry, 'postalCode' ) ) {
            $update = 1;
        }
        if( $self->_modifyAttr( $self->{'entityDesc'}->{'address'}->{'work'}->{'town'}, $entry, 'l' ) ) {
            $update = 1;
        }
        if( $self->_modifyAttr( $self->{'entityDesc'}->{'address'}->{'prefered'}, $entry, 'registeredAddress' ) ) {
            $update = 1;
        }
    
        if( $self->_modifyAttr( $self->{'entityDesc'}->{'email'}, $entry, 'mail' ) ) {
            $update = 1;
        }
    
        if( $self->_modifyAttr( $self->{'entityDesc'}->{'website'}, $entry, 'URL' ) ) {
            $update = 1;
        }
        if( $self->_modifyAttr( $self->{'entityDesc'}->{'website'}, $entry, 'workUrl' ) ) {
            $update = 1;
        }
    }

    if( $self->getUpdateLinks() ) {
    
    }

    return $update;
}
