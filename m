From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Mar 2012 13:44:17 -0800
Subject: [PATCH 11/12] mfd: twl4030-irq: Return twl6030_mmc_card_detect
 IRQ for board setup
In-Reply-To: <4F513DCA.1070301@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-12-git-send-email-b-cousson@ti.com>
 <20120302181522.GC13967@legolas.emea.dhcp.ti.com>
 <20120302192058.GP18901@atomide.com> <4F512D72.1090002@ti.com>
 <4F513DCA.1070301@ti.com>
Message-ID: <20120302214416.GQ18901@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [120302 13:06]:
> 
> I created a for_3.4/twl_irq_gpio_fix branch based on irqdomain/next
> with all the TWL + GPIO patches except the DTS and without the MMC
> hacks.
> 
> And I merged it into your hsmmc-gpio branch. There is a small
> conflict in gpio-twl4030 but otherwise it works on the SDP4430.

OK cool.
 
> I cannot test remotely with Panda or Beagle, the animals are already
> sleeping.
> 
> The branch is there if you want to check for OMAP3 as well.
> git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git
> for_3.4/twl_irq_gpio_fix

I'll give it a try at some point, looks like there's few more
hsmmc fixes needed first..

Tony
