From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Fri, 04 May 2012 21:39:32 +0200
Subject: [PATCH] omap: dma: Clear status registers on enable/disable irq.
In-Reply-To: <20120504165146.GB5613@atomide.com>
References: <1334954578-10478-1-git-send-email-oleg.matcovschi@ti.com>
 <20120504165146.GB5613@atomide.com>
Message-ID: <1633215.yCrxk1mQVq@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dnia pi?tek, 4 maja 2012 09:51:46 Tony Lindgren pisze:
> Hi,
> 
> * Oleg Matcovschi <oleg.matcovschi@ti.com> [120420 13:49]:
> > Use omap_disable_channel_irq() function instead of directly 
accessing CICR.
> > The omap_disable_chanel_irq() function clears pending interrupts
> > and disables interrupt on channel.
> > Functions omap2_enable_irq_lch()/omap2_disable_irq_lch() clear 
interrupt
> > status register.
> 
> This seems like a nice fix to me. As it affects all omaps, I'd like to
> see some tested-by from Janusz/Jarkko/Peter. Can you guys give it a 
try
> with some audio tests?

OK, I can do, but perhaps not before next Saturday, when I'm back home, 
able to actually listen to the audio, not only watch the IRQ counters 
rising up ;-).

Thanks,
Janusz
