From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Nov 2012 14:25:20 +0000
Subject: [PATCH 2/3] ARM: OMAP: Remove NEED_MACH_GPIO_H
In-Reply-To: <20121101224823.2103.24591.stgit@muffinssi.local>
References: <20121101224703.2103.95474.stgit@muffinssi.local>
 <20121101224823.2103.24591.stgit@muffinssi.local>
Message-ID: <20121102142519.GZ4413@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2012 at 03:48:23PM -0700, Tony Lindgren wrote:
> Omap no longer needs this option, mach/gpio.h is
> empty.
> 
> Also remove mach/irqs.h from gpio-omap.h and
> include it directly from the related omap1
> gpio init files.
> 
> Otherwise omap2+ build fails for MULTI_PLATFORM.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121102/00a04e77/attachment-0001.sig>
