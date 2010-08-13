From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Aug 2010 15:26:46 +0100
Subject: [PATCH 5/5] ASoc: add machine driver for 88pm860x
In-Reply-To: <AANLkTikpcA0RTxdGne2L5n06d0AjfnWEMsh0GP8nvyO6@mail.gmail.com>
References: <AANLkTikpcA0RTxdGne2L5n06d0AjfnWEMsh0GP8nvyO6@mail.gmail.com>
Message-ID: <20100813142646.GE6449@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 13, 2010 at 09:55:53PM +0800, Haojian Zhuang wrote:
> From cd2063f68b233a86b24efa3f4dc3ca3c438b1576 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Thu, 12 Aug 2010 12:04:23 +0800

Please fix your configuration for sending patches - none of this header
stuff should be in the body of the mail.

> Subject: [PATCH 5/5] ASoc: add machine driver for 88pm860x

It's not a machine driver for this CODEC, it appears to be two machine
drivers for...

> 88PM860x codec is used in Marvell development board (Saarb and tavorevb3).
> Codec is used as master mode in both of these two boards.

...these two boards.  I'd suggest supplying one board per patch.

> +#include "../../arm/pxa2xx-pcm.h"

Why?

> +	SND_SOC_DAPM_SPK("Board Speaker", NULL),
> +	SND_SOC_DAPM_MIC("Board Mic 1", NULL),
> +	SND_SOC_DAPM_MIC("Board Mic 3", NULL),

What happened to Mic 2?
