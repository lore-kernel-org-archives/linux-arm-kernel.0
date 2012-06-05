From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Jun 2012 23:39:13 -0700
Subject: [PATCH v2] omap: dma: Clear status registers on enable/disable
 irq.
In-Reply-To: <2491206.Xgf8oVG38F@acer>
References: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
 <2491206.Xgf8oVG38F@acer>
Message-ID: <20120605063912.GB12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [120604 15:01]:
> On Tue, 15 May 2012 14:35:08 Oleg Matcovschi wrote:
> > Use omap_disable_channel_irq() function instead of directly accessing CICR.
> > The omap_disable_chanel_irq() function clears pending interrupts
> > and disables interrupt on channel.
> > Functions omap2_enable_irq_lch()/omap2_disable_irq_lch() clear interrupt
> > status register.
> > 
> > 
> > Signed-off-by: Oleg Matcovschi <oleg.matcovschi@ti.com>
> > ---
> > v1 initial revision
> > v2 Review by Tony Lindgren
> 
> My Tested-by: on OMAP1 still valid for v2 if you care.

OK good to hear, will add that.

Regards,

Tony
