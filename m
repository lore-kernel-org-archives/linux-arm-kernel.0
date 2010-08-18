From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Wed, 18 Aug 2010 15:06:59 +0100
Subject: [PATCH 2/3] ASoC: add tavorevb3 machine driver for 88pm860x
In-Reply-To: <AANLkTi=o7+GtXz1ZxuLJiYkREpMB=RPckig95FQrSqLd@mail.gmail.com>
References: <AANLkTi=o7+GtXz1ZxuLJiYkREpMB=RPckig95FQrSqLd@mail.gmail.com>
Message-ID: <1282140419.3117.465.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-08-18 at 21:49 +0800, Haojian Zhuang wrote:
> >From 114a6f2d4629b0bbff4c4ce9b4a633ddf7e25498 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Tue, 17 Aug 2010 13:24:35 +0800
> Subject: [PATCH 2/3] ASoC: add tavorevb3 machine driver for 88pm860x
> 
> 88PM860x codec is used in Marvell tavorevb3 development board. 88PM860x
> codec is used as master mode of SSP communication. Only I2S format is
> supported.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  sound/soc/pxa/Kconfig      |    9 +
>  sound/soc/pxa/Makefile     |    2 +
>  sound/soc/pxa/pxa2xx-ssp.c |  532 ++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/pxa/pxa2xx-ssp.h |   59 +++++
>  sound/soc/pxa/ssp.c        |  298 +++++++++++++++++++++++++

I dont think you meant to include the SSP driver.

Thanks

Liam
