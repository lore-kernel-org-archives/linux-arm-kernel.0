From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 16 Jul 2014 13:15:09 +0200
Subject: ARM: shmobile: r7s72100: genmai: CONFIG_MACH_GENMAI
Message-ID: <1405509309.4408.36.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit bec652e2fbfe ("ARM: shmobile: r7s72100: genmai: Remove legacy
board file") is included in linux-next as of next-20140716.

It removed the Kconfig symbol MACH_GENMAI (twice!). It also removed its
macro from a Makefile. It did not touch its macro from
arch/arm/mach-shmobile/Makefile.boot.

Is the trivial patch to remove CONFIG_MACH_GENMAI from that Makefile
queued somewhere?


Paul Bolle
