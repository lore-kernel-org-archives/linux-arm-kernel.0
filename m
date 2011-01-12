From: yong.shen@linaro.org (Yong Shen)
Date: Wed, 12 Jan 2011 18:03:27 +0800
Subject: [PATCH v3 1/4] ARM: i.MX53: enable spi support
In-Reply-To: <20110112093710.GD24920@pengutronix.de>
References: <1294821324-5688-1-git-send-email-yong.shen@freescale.com>
	<1294821324-5688-2-git-send-email-yong.shen@freescale.com>
	<20110112093710.GD24920@pengutronix.de>
Message-ID: <AANLkTikS=cWfj1g0q8aj-d=5X8LvDduRn1xL4zJncJVs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Uwe,

>> ?#define MX53_PAD_EIM_D20__GPIO_3_20 ? ? ? ? ?IOMUX_PAD(0x470, 0x128,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
>> ?#define MX53_PAD_EIM_D21__GPIO_3_21 ? ? ? ? ?IOMUX_PAD(0x474, 0x12C,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
> Why do you remove the GPIO definitions?
>
Why not? Anyway they are always used as cspi signals. IMO, we don't
need keep that many configures, and it's better to add them when
needed.

thanks
Yong
