From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 7 Jun 2011 23:43:06 +0530
Subject: TI-Davinci 6446 oops on interrupts
In-Reply-To: <alpine.LFD.2.02.1106062330380.13964@ionos>
References: <4DECCADE.6080100@selfish.org> <4DECD8C0.6010908@freyther.de>
	<alpine.LFD.2.02.1106061650210.13964@ionos>	<4DECEDF9.4010202@selfish.org>
	<alpine.LFD.2.02.1106061719290.13964@ionos>	<4DECF32B.6000508@selfish.org>
	<alpine.LFD.2.02.1106062330380.13964@ionos>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D383CDB@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, Jun 07, 2011 at 03:01:31, Thomas Gleixner wrote:

> > > Subject: arm: davinci: Fix fallout from generic irq chip conversion
> > > From: Thomas Gleixner <tglx@linutronix.de>
> > > Date: Mon, 06 Jun 2011 11:51:43 +0200
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Tested-by: Holger Hans Peter Freyther <holger@freyther.de>
> 
> can you please pick that up? It should have a Cc: stable at kernel.org
> tag as well.

But generic IRQ chip support for DaVinci was merged only in
v3.0-rc1.

$ git log --tags --source --oneline arch/arm/mach-davinci/irq.c
aac4dd1 v3.0-rc1 arm: davinci: Use generic irq chip

Thanks,
Sekhar
