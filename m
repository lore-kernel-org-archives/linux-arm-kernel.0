From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 9 Oct 2012 15:29:38 +0900
Subject: [PATCH] ARM: pxa: Fix build error caused by sram.h rename
In-Reply-To: <87vcenespj.fsf@octavius.laptop.org>
References: <87vcenespj.fsf@octavius.laptop.org>
Message-ID: <20121009062936.GM8237@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 06, 2012 at 07:38:16AM -0400, Chris Ball wrote:
> Commit 293b2da1b61 ("ARM: pxa: move platform_data definitions")
> renamed arch/arm/mach-mmp/include/mach/sram.h to
> include/linux/platform_data/dma-mmp_tdma.h, but didn't update
> mmp-pcm.c which uses the header.  Fix the build error.

Applied, thanks.
