From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 4 Nov 2014 22:13:28 +0100 (CET)
Subject: [PATCH v2] ARM: irqchip: mxs: add Alpascale ASM9260 support
In-Reply-To: <545936AD.5060009@rempel-privat.de>
References: <20141104130320.GB21210@tiger>
 <1415128357-12054-1-git-send-email-linux@rempel-privat.de>
 <alpine.DEB.2.11.1411042118490.4245@nanos>
 <545936AD.5060009@rempel-privat.de>
Message-ID: <alpine.DEB.2.11.1411042209110.4245@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Nov 2014, Oleksij Rempel wrote:

> Am 04.11.2014 um 21:20 schrieb Thomas Gleixner:
> > On Tue, 4 Nov 2014, Oleksij Rempel wrote:
> > 
> >> Freescale iMX23/iMX28 and Alphascale ASM9260 have similar
> >> interrupt collectors. It makes easy to reuse irq-mxs code for ASM9260.
> >> Differences between this devices are fallowing:
> >> - different register offsets
> >> - different count of intterupt lines per register
> >> - ASM9260 don't provide reset bit
> >> - ASM9260 don't support FIQ.
> > 
> > Why is this a monolithic patch again. IIRC it was split into a
> > prepatory (imx) and alphascale part earlier. But my memory might trick
> > me.
> 
> It is not monolithic. first patch is "[PATCH v8 4/9] ARM: irqchip: mxs:
> prepare driver for HW with different offsets".

So you sent that very patch out of context and then you wonder why I
stumble over that?

> I don't really wont do discus this irq patches now. Please keep
> attention on first two, /arch/arm/ patches.

Then do not send them in the first place. I'm not involved in your
arch/arm patches, but I care about the stuff which is supposed to hit
the part of the tree which I maintain.

Please keep your attention on sending stuff in the right order to the
right people at the right time.

Thanks,

	tglx
