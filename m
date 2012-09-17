From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Sep 2012 07:45:43 -0400
Subject: [PATCH 16/34] ASoC: imx-ssi: remove unneeded mach/hardware.h
 inclusion
In-Reply-To: <1347860103-4141-17-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-17-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120917114543.GG5401@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 01:34:45PM +0800, Shawn Guo wrote:

>  #include <linux/platform_data/asoc-imx-ssi.h>
> -#include <mach/hardware.h>

This doesn't apply - there's no platform data header for imx-ssi at the
minute (and I don't see a patch in this series related to that in the
series).  I checked -next and there doesn't seem to be anything via a
non-ASoC tree either.
