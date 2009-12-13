From: jassisinghbrar@gmail.com (jassi brar)
Date: Sun, 13 Dec 2009 18:17:46 +0900
Subject: [PATCH 3/7] ARM: S3C64XX: Add I2S resources in platform code
In-Reply-To: <20091209104736.GA19851@opensource.wolfsonmicro.com>
References: <1260333123-11609-1-git-send-email-jassisinghbrar@gmail.com>
	<20091209104736.GA19851@opensource.wolfsonmicro.com>
Message-ID: <1b68c6790912130117n283ba479nfd8142842713cf8e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 9, 2009 at 7:47 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Dec 09, 2009 at 01:32:03PM +0900, jassisinghbrar at gmail.com wrote:
>
>> +static int s3c64xx_i2sv4_cfg_gpio(struct platform_device *pdev)
>> +{
>> + ? ? s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S0_V40_DO);
>> + ? ? s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S1_V40_DO);
>> + ? ? s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S2_V40_DO);
>
> A variant of this should already have been merged, and the names of the
> GPIO defines were altered to make it look less like there's multiple
> controllers rather than multiple data lines.
I can see I2S_V4 MACRO renaming but nothing else that this patch does.
So, i shud resubmit with only new v4-DO MACROs, right?
