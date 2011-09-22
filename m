From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 22 Sep 2011 11:42:52 +0200
Subject: [PATCH 53/57] sound: irq: Remove IRQF_DISABLED
In-Reply-To: <alpine.LFD.2.02.1109211154280.2723@ionos>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-54-git-send-email-yong.zhang0@gmail.com>
	<s5hsjnqxlxb.wl%tiwai@suse.de>
	<alpine.LFD.2.02.1109211154280.2723@ionos>
Message-ID: <s5hhb44gbfn.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Wed, 21 Sep 2011 11:55:36 +0200 (CEST),
Thomas Gleixner wrote:
> 
> > > We run all interrupt handlers with interrupts disabled
> > > and we even check and yell when an interrupt handler
> > > returns with interrupts enabled (see commit [b738a50a:
> > > genirq: Warn when handler enables interrupts]).
> > > 
> > > So now this flag is a NOOP and can be removed.
> > > 
> > > Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> > > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > 
> > Do you want to merge by yourself or shall I take it to sound git tree?
> > Since IRQF_DISABLED isn't used, it can be applied safely in 3.1-based
> > tree, right?
> 
> Yes, please go ahead. I'll pick up the leftovers.

OK, I applied Yong's (fixed) patch now to sound git tree.


thanks,

Takashi
