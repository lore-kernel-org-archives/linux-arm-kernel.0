From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 18 Aug 2010 22:08:22 +0800
Subject: [PATCH 2/3] ASoC: add tavorevb3 machine driver for 88pm860x
In-Reply-To: <1282140419.3117.465.camel@odin>
References: <AANLkTi=o7+GtXz1ZxuLJiYkREpMB=RPckig95FQrSqLd@mail.gmail.com>
	<1282140419.3117.465.camel@odin>
Message-ID: <AANLkTi=j7383au6=J7eeY-axSKUXBvOGoPEVr=2NQTNe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 18, 2010 at 10:06 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Wed, 2010-08-18 at 21:49 +0800, Haojian Zhuang wrote:
>> >From 114a6f2d4629b0bbff4c4ce9b4a633ddf7e25498 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Tue, 17 Aug 2010 13:24:35 +0800
>> Subject: [PATCH 2/3] ASoC: add tavorevb3 machine driver for 88pm860x
>>
>> 88PM860x codec is used in Marvell tavorevb3 development board. 88PM860x
>> codec is used as master mode of SSP communication. Only I2S format is
>> supported.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> ?sound/soc/pxa/Kconfig ? ? ?| ? ?9 +
>> ?sound/soc/pxa/Makefile ? ? | ? ?2 +
>> ?sound/soc/pxa/pxa2xx-ssp.c | ?532 ++++++++++++++++++++++++++++++++++++++++++++
>> ?sound/soc/pxa/pxa2xx-ssp.h | ? 59 +++++
>> ?sound/soc/pxa/ssp.c ? ? ? ?| ?298 +++++++++++++++++++++++++
>
> I dont think you meant to include the SSP driver.
>

I'm sorry that it's caused by mistake. I'll remove it and send it again.
> Thanks
>
> Liam
>
>
>
