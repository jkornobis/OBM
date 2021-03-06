#################################################################################
# Copyright (C) 2011-2012 Linagora
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version, provided you comply with the Additional Terms applicable for OBM
# software by Linagora pursuant to Section 7 of the GNU Affero General Public
# License, subsections (b), (c), and (e), pursuant to which you must notably (i)
# retain the displaying by the interactive user interfaces of the “OBM, Free
# Communication by Linagora” Logo with the “You are using the Open Source and
# free version of OBM developed and supported by Linagora. Contribute to OBM R&D
# by subscribing to an Enterprise offer !” infobox, (ii) retain all hypertext
# links between OBM and obm.org, between Linagora and linagora.com, as well as
# between the expression “Enterprise offer” and pro.obm.org, and (iii) refrain
# from infringing Linagora intellectual property rights over its trademarks and
# commercial brands. Other Additional Terms apply, see
# <http://www.linagora.com/licenses/> for more details.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License and
# its applicable Additional Terms for OBM along with this program. If not, see
# <http://www.gnu.org/licenses/> for the GNU Affero General   Public License
# version 3 and <http://www.linagora.com/licenses/> for the Additional Terms
# applicable to the OBM software.
#################################################################################


package OBM::Ldap::ldapServers;

$VERSION = "1.0";

use Class::Singleton;
use OBM::Log::log;
@ISA = ('Class::Singleton', 'OBM::Log::log');

$debug = 1;

use 5.006_001;
require Exporter;
use strict;

require OBM::Parameters::regexp;


sub _new_instance {
    my $class = shift;

    my $self = bless { }, $class;

    $self->{'servers'} = undef;

    return $self;
}


sub DESTROY {
    my $self = shift;

    $self->_log( 'suppression de l\'objet', 5 );
    $self->{'servers'} = undef;
}


sub getLdapServer {
    my $self = shift;
    my( $serverId ) = @_;

    if( !defined($serverId) ) {
        $self->_log( 'identifiant de serveur non défini', 1 );
        return undef;
    }

    if( ref($serverId) || ($serverId !~ /$OBM::Parameters::regexp::regexp_server_id/) ) {
        $self->_log( 'identifiant de serveur incorrect', 1 );
        return undef;
    }

    if( exists($self->{'servers'}->{$serverId}) ) {
        $self->_log( 'serveur d\'identifiant \''.$serverId.'\' déjà chargé', 4 );
        if( !defined($self->{'servers'}->{$serverId}) ) {
            $self->_log( 'serveur d\'identifiant \''.$serverId.'\' non défini', 1 );
            return undef;
        }
    }elsif( !$self->_loadServer( $serverId ) ) {
        return undef;
    }

    return $self->{'servers'}->{$serverId};
}


sub getLdapServerConn {
    my $self = shift;
    my( $serverId ) = @_;

    if( !$self->getLdapServer($serverId ) ) {
        return undef;
    }

    $self->_log( 'obtention de la connexion au '.$self->{'servers'}->{$serverId}->getDescription(), 5 );
    return $self->{'servers'}->{$serverId}->getConn();
}


sub _loadServer {
    my $self = shift;
    my( $serverId ) = @_;

    $self->_log( 'chargement du serveur LDAP d\'identifiant \''.$serverId.'\'', 4 );

    require OBM::Ldap::ldapServer;
    $self->{'servers'}->{$serverId} = OBM::Ldap::ldapServer->new( $serverId );

    if( !defined($self->{'servers'}->{$serverId}) ) {
        $self->_log( 'serveur d\'identifiant \''.$serverId.'\' non trouvé', 1 );
    }

    return $self->{'servers'}->{$serverId};
}
