From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 09 Feb 2015 14:03:37 +0100
Subject: ARM: CACHE_PL310
Message-ID: <1423487017.2246.118.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Your commit 20e783e39e55 ("ARM: 8296/1: cache-l2x0: clean up aurora
cache handling") is included in today's linux-next (ie, next-20150209).
I noticed because a script I use to check linux-next spotted a problem
with it.

That commit removed the only user of the Kconfig symbol CACHE_PL310.
Setting CACHE_PL310 is now pointless in linux-next. Is the trivial patch
to remove its Kconfig entry (and one select of this symbol in
arch/arm/mach-at91/Kconfig) queued somewhere?


Paul Bolle
