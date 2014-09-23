From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 15:03:32 +0200
Subject: [PATCH v2 4/4] ARM: dts: mt8135: Add pinctrl node for mt8135.
In-Reply-To: <1411443545-24951-5-git-send-email-srv_hongzhou.yang@mediatek.com>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411443545-24951-5-git-send-email-srv_hongzhou.yang@mediatek.com>
Message-ID: <2770365.r419rjIAOU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 11:39:05 Hongzhou. Yang wrote:
> +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_GPIO0 (MT_PIN_NO(0) | 0)
> +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_MSDC0_DAT7 (MT_PIN_NO(0) | 1)
> +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_EINT49 (MT_PIN_NO(0) | 2)
> +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_I2SOUT_DAT (MT_PIN_NO(0) | 3)
> +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_DAC_DAT_OUT (MT_PIN_NO(0) | 4)
> +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_PCM1_DO (MT_PIN_NO(0) | 5)
> +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_SPI1_MO (MT_PIN_NO(0) | 6)
> +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_NALE (MT_PIN_NO(0) | 7)
> +

This list looks like it just describes the hardware, I think it would
be better to put the values directly into the DT, rather than
using such macros.

	Arnd
