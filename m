From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 4 Nov 2014 21:20:13 +0100 (CET)
Subject: [PATCH v2] ARM: irqchip: mxs: add Alpascale ASM9260 support
In-Reply-To: <1415128357-12054-1-git-send-email-linux@rempel-privat.de>
References: <20141104130320.GB21210@tiger>
 <1415128357-12054-1-git-send-email-linux@rempel-privat.de>
Message-ID: <alpine.DEB.2.11.1411042118490.4245@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Nov 2014, Oleksij Rempel wrote:

> Freescale iMX23/iMX28 and Alphascale ASM9260 have similar
> interrupt collectors. It makes easy to reuse irq-mxs code for ASM9260.
> Differences between this devices are fallowing:
> - different register offsets
> - different count of intterupt lines per register
> - ASM9260 don't provide reset bit
> - ASM9260 don't support FIQ.

Why is this a monolithic patch again. IIRC it was split into a
prepatory (imx) and alphascale part earlier. But my memory might trick
me.

Thanks,

	tglx
