From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Dec 2010 09:44:08 -0800
Subject: [PATCH 1/3] omap1: Use asm_irq_flags for entry-macro.S
In-Reply-To: <201012101706.24089.jkrzyszt@tis.icnet.pl>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
	<20101208014548.GJ17435@atomide.com>
	<20101208014728.GK17435@atomide.com>
	<201012101706.24089.jkrzyszt@tis.icnet.pl>
Message-ID: <20101210174407.GV3054@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101210 08:06]:
> Wednesday 08 December 2010 02:47:28 Tony Lindgren napisa?(a):
> > Initialize asm_irq_flags in omap_init_irq and use it in
> > get_irqnr_and_base to detect between omap7xx and omap15xx/16xx.
> >
> > Note that both INT_1510_IH2_IRQ and INT_1510_IH2_IRQ are defined
> > as 0, so use INT_1510_IH2_IRQ for both of them.
> 
> Tested on Amstrad Delta.
> 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Thanks, merging these into omap-for-linus.

Regards,

Tony
