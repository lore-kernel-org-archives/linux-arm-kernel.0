From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 19 Nov 2012 16:58:59 +0000
Subject: [PATCH] ARM: Kconfig: Do not select ARCH_VEXPRESS on ARCH_MULTI_V7
In-Reply-To: <20121119175440.1096f725@skate>
References: <1353343080-19220-1-git-send-email-fabio.estevam@freescale.com>
 <1353343497.3303.34.camel@hornet> <20121119175440.1096f725@skate>
Message-ID: <1353344339.3303.36.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-19 at 16:54 +0000, Thomas Petazzoni wrote:
> On Mon, 19 Nov 2012 16:44:57 +0000, Pawel Moll wrote:
> 
> > It's a bug in vexpress-sysreg driver. 3 hours ago I've posted patch
> > removing this code...
> > 
> > https://patchwork.kernel.org/patch/1764801/
> > 
> > Apologies about causing the issue in the first place.
> 
> But still, the patch that Fabio raises is interesting: why would
> ARCH_VEXPRESS be unconditionally enabled when building an ARM
> multiplatform kernel for v6/v7 ? I may want to build a kernel with
> several platforms, but not necessarily vexpress, no?

I'm not arguing this. As far as I remember Rob wanted to make vexpress a
default for the multiplatform kernel, but you're right saying that
forcing it with the SELECT was probably a step too far.

Pawe?
