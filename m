From: eric.miao@linaro.org (Eric Miao)
Date: Tue, 1 Mar 2011 16:21:37 +0800
Subject: [PATCH 1/2] ARM imx53: add pwm devices support
In-Reply-To: <20110301081043.GS22310@pengutronix.de>
References: <1298961018-8988-1-git-send-email-b02280@freescale.com>
	<20110301081043.GS22310@pengutronix.de>
Message-ID: <AANLkTin5SCtSZfFhErb9baWpMioDWk=UA15cOddb1B=R@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> ?config IMX_HAVE_PLATFORM_MXC_PWM
>> ? ? ? bool
>> + ? ? default y if ARCH_MX21 || ARCH_MX25 || SOC_IMX27 || SOC_IMX51 || SOC_IMX53
> If you do this, can you please use SOC_IMX21 and SOC_IMX25? ?Or maybe
> even def_bool y?
>

Or the other way, in config SOC_IMX53, select IMX_HAVE_PLATFORM_MXC_PWM?
