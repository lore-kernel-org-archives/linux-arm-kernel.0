From: nils.faerber@kernelconcepts.de (Nils Faerber)
Date: Wed, 01 Dec 2010 15:12:27 +0100
Subject: State of SMP / dual-core for MV78200?
Message-ID: <4CF657CB.70901@kernelconcepts.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!
I have a Marvell Discover MV78200 at hand and am wondering about the
multi core support in ARM Linux for it. I know that the Marvell based
kernel suports dual-system, i.e. booting two kernel instances on the two
cores. I also see that the upstream kernel still has the hooks for this
in the board support files (for distributing the resources between the
cores). Does anyone here know about the status about this dual-system
support?
And wouldn't SMP also work on such CPUs, i.e. having one kernel instance
with two cores? For the application in question SMP would make more
sense (high data I/O traffic).

Any information is welcome!

Cheers
  nils

-- 
kernel concepts GbR      Tel: +49-271-771091-12
Sieghuetter Hauptweg 48  Fax: +49-271-771091-19
D-57072 Siegen           Mob: +49-176-21024535
http://www.kernelconcepts.de
