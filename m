From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Mon, 08 Apr 2013 21:19:27 +0900
Subject: [PATCH v3] mmc: dw_mmc: let device core setup the default pin
 configuration
In-Reply-To: <1365170015-3009-1-git-send-email-thomas.abraham@linaro.org>
References: <1365170015-3009-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <003501ce3453$502adf80$f0809e80$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 05, 2013, Thomas Abraham wrote:
> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

I hope that your another patch is merged.
 ARM: dts: add pinctrl nodes for Exynos5250 SoC
I didn't check whether it is applied.

Thanks,
Seungwon Jeon
