From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 17:54:40 +0100
Subject: [PATCH] ARM: Kconfig: Do not select ARCH_VEXPRESS on ARCH_MULTI_V7
In-Reply-To: <1353343497.3303.34.camel@hornet>
References: <1353343080-19220-1-git-send-email-fabio.estevam@freescale.com>
 <1353343497.3303.34.camel@hornet>
Message-ID: <20121119175440.1096f725@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 19 Nov 2012 16:44:57 +0000, Pawel Moll wrote:

> It's a bug in vexpress-sysreg driver. 3 hours ago I've posted patch
> removing this code...
> 
> https://patchwork.kernel.org/patch/1764801/
> 
> Apologies about causing the issue in the first place.

But still, the patch that Fabio raises is interesting: why would
ARCH_VEXPRESS be unconditionally enabled when building an ARM
multiplatform kernel for v6/v7 ? I may want to build a kernel with
several platforms, but not necessarily vexpress, no?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
