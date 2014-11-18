From: francesco@dolcini.it (Francesco Dolcini)
Date: Tue, 18 Nov 2014 15:25:20 +0100
Subject: ARM: mvebu: ethernet packets corruption and I/O coherency
Message-ID: <20141118142520.GD24819@dev0.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas and all,
I have seen your patches ("ARM: mvebu: no I/O coherency on non-SMP and
related updates") regarding I/O coherency and I think it might be
related to a problem I am experiencing.

I do have a custom board based on Marvell Armada 370 running kernel
3.13.11 and I see random outgoing ethernet packet corruption (about 1
packet every some million) using mvneta driver.

I have tried linux kernel 3.17 without any improvement.

What do you think? Can you backport the fix to 3.13 kernel?

Regards,
	Francesco
