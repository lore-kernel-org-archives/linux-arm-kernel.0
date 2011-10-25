From: tony@atomide.com (Tony Lindgren)
Date: Tue, 25 Oct 2011 09:48:16 +0200
Subject: GIC MULTI_IRQ_HANDLER branches
In-Reply-To: <20111024162612.728acd58@taxman.wild-wind.fr.eu.org>
References: <20111024162612.728acd58@taxman.wild-wind.fr.eu.org>
Message-ID: <20111025074815.GG4429@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <maz@misterjones.org> [111024 16:59]:
> I've stashed my patches for MULTI_IRQ_HANDLER on the following branches:
> git://github.com/mzyngier/arm-platforms.git gic-multi-irq
> git://github.com/mzyngier/arm-platforms.git gic-multi-irq-asm
> 
> This is based on Russell's smp branch, plus my PPI patches that Russell
> has already pulled for the upcoming merge window.
> 
> The difference between the two branches is that the second is keeping
> the ASM version of the GIC handler instead of a C version.
> 
> The C version has been tested on VE, Realview, Tegra, and OMAP2/3/4.
> The ASM version has only been tested on OMAP4.

For the record, boots fine on omap1/2/3/4 like I replied earlier
with my Tested-by.

Can people please test this series on all subarchs so Marc can
then remove the remaining assembly code too.

Regards,

Tony
