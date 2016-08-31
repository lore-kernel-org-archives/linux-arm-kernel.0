From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 31 Aug 2016 14:42:57 +0200
Subject: [PATCH 1/9] ARM: dts: exynos: Add macros for GPIO configuration
In-Reply-To: <1472645613-5362-2-git-send-email-k.kozlowski@samsung.com>
References: <1472645613-5362-1-git-send-email-k.kozlowski@samsung.com>
 <1472645613-5362-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <28320955.k33BrW2NEN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 31, 2016 2:13:25 PM CEST Krzysztof Kozlowski wrote:
> 
> +#define PIN_PULL_NONE          0
> +#define PIN_PULL_DOWN          1
> +#define PIN_PULL_UP            3
> +
> +#define PIN_DRV_LV1            0
> +#define PIN_DRV_LV2            2
> +#define PIN_DRV_LV3            1
> +#define PIN_DRV_LV4            3
> +
> +#define PIN_FUNC_INPUT         0
> +#define PIN_FUNC_OUTPUT                1
> +#define PIN_FUNC_SPC_2         2
> +#define PIN_FUNC_SPC_3         3
> +#define PIN_FUNC_SPC_4         4
> +#define PIN_FUNC_SPC_5         5
> +#define PIN_FUNC_SPC_F         0xf

Any reason for having a copy in each of those files instead of one
that is shared across all of them?

	Arnd
