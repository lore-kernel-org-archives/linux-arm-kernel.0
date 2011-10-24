From: maz@misterjones.org (Marc Zyngier)
Date: Mon, 24 Oct 2011 16:26:12 +0100
Subject: GIC MULTI_IRQ_HANDLER branches
Message-ID: <20111024162612.728acd58@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've stashed my patches for MULTI_IRQ_HANDLER on the following branches:
git://github.com/mzyngier/arm-platforms.git gic-multi-irq
git://github.com/mzyngier/arm-platforms.git gic-multi-irq-asm

This is based on Russell's smp branch, plus my PPI patches that Russell
has already pulled for the upcoming merge window.

The difference between the two branches is that the second is keeping
the ASM version of the GIC handler instead of a C version.

The C version has been tested on VE, Realview, Tegra, and OMAP2/3/4.
The ASM version has only been tested on OMAP4.

Cheers,

	M.
-- 
I'm the slime oozin' out from your TV set...
