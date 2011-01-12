From: yong.shen@linaro.org (Yong Shen)
Date: Wed, 12 Jan 2011 18:10:26 +0800
Subject: [PATCH v3 2/4] ARM: i.MX53 EVK: add spi device
In-Reply-To: <20110112094033.GE24920@pengutronix.de>
References: <1294821324-5688-1-git-send-email-yong.shen@freescale.com>
	<1294821324-5688-3-git-send-email-yong.shen@freescale.com>
	<20110112094033.GE24920@pengutronix.de>
Message-ID: <AANLkTimFGB1BysGiQhgpc9Dq=6t8JYdeKDY_iR1=HzO7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

>> + ? ? MX53_PAD_EIM_D16__CSPI1_SCLK,
>> + ? ? MX53_PAD_EIM_D17__CSPI1_MISO,
>> + ? ? MX53_PAD_EIM_D18__CSPI1_MOSI,
> did the v2 patch work at all?

Yes, it did work. Only the pad names were wrong, the configurations
were right, so v3 changed the names to match the configuration.

cheers
Yong
