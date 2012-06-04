From: tony@atomide.com (Tony Lindgren)
Date: Sun, 3 Jun 2012 23:13:57 -0700
Subject: [PATCH v2] omap: dma: Clear status registers on enable/disable
 irq.
In-Reply-To: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
References: <1337117708-27215-1-git-send-email-oleg.matcovschi@ti.com>
Message-ID: <20120604061357.GV12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Oleg Matcovschi <oleg.matcovschi@ti.com> [120515 14:40]:
> Use omap_disable_channel_irq() function instead of directly accessing CICR.
> The omap_disable_chanel_irq() function clears pending interrupts
> and disables interrupt on channel.
> Functions omap2_enable_irq_lch()/omap2_disable_irq_lch() clear interrupt
> status register.

Looking at this again, I'll apply this into cleanup-dma instead of fixes.

If it fixes something that I can't see, please reply with a description
what it fixes and I'll move it into fixes.

Regards,

Tony
