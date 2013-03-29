From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Mar 2013 10:20:15 +0100
Subject: [PATCHv2 00/10] ARM: sunxi: Architecture cleanups and rework
In-Reply-To: <1364289198-11589-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1364289198-11589-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <51555CCF.2090005@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Le 26/03/2013 10:13, Maxime Ripard a ?crit :
> Hi,
> 
> This patchset is a serie of various cleanups and reworks in the sunxi
> architecture to prepare a clean landing for the next Allwinner SoC, the
> A31 (sun6i).
> 
> The A31 is significantly different from the previous Allwinner SoC we
> supported, the A10 and A13, to no longer make the generic sunxi prefix
> we used in most compatible string relevant, while it should really have
> been sun4i in the first place.
> 
> This set is also the occasion to cleanup the timer and irq code by
> switching to the recently introduced clocksource and irqchip
> infrastructures.
> 
> This set depends on the UART patches I sent previously.

I was meaning to take this branch, but some of the drivers changes in it
depends on the clock patches that Emilio sent and that are in clk-next.
Is it ok to merge clk-next into my branch?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
