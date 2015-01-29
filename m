From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jan 2015 17:50:30 +0100
Subject: [PATCH] [TEMPORARY] net: netfilter: IPV6 XT sockets need
 CONFIG_NF_DEFRAG_IPV6
In-Reply-To: <1513018.IdvuSAziQY@wuerfel>
References: <1513018.IdvuSAziQY@wuerfel>
Message-ID: <1699413.oLnudLOjvJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 January 2015 17:18:59 Arnd Bergmann wrote:
> If IP6_NF_IPTABLES=m, NF_DEFRAG_IPV6 gets selected as a module as well
> from NETFILTER_XT_MATCH_SOCKET, so the latter cannot be built-in, or
> we get:

I messed up the subject line, the [TEMPORARY] was not meant to be
in there, and I also saw that the subject was mixed up too.

I will send it again with the proper subject.

	Arnd
