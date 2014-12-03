From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed, 3 Dec 2014 12:24:07 -0800
Subject: [PATCH] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <1417438770-28696-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1417438770-28696-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <CANMBJr4B-c-eMCvwexW5_WhfK=xsJ0-Cjo_OApTpUXP3zBG-kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 December 2014 at 04:59, Sjoerd Simons
<sjoerd.simons@collabora.co.uk> wrote:
> Add DTS for the Hardkernel Odroid XU3. The name of the DTS file is kept the
> same as the vendors naming, which means it's prefixed with exynos5422
> instead of exynos5800 as the SoC name even though it includes the
> exyno5800 dtsi.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Tested-by: Tyler Baker <tyler.baker@linaro.org>

Tested this atop of next-20141203 both on exynos_defconfig and
multi_v7_defconfig. All configurations boot fine on my odroid-xu3
board, no imprecise aborts observed either.

Thanks!

Tyler
