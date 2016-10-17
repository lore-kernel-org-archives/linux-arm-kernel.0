From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 17 Oct 2016 19:46:09 +0300
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable exynos-gsc driver as
 module
In-Reply-To: <1475677469-1524-2-git-send-email-javier@osg.samsung.com>
References: <1475677469-1524-1-git-send-email-javier@osg.samsung.com>
 <1475677469-1524-2-git-send-email-javier@osg.samsung.com>
Message-ID: <20161017164609.GB15435@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2016 at 11:24:29AM -0300, Javier Martinez Canillas wrote:
> Exynos5 SoCs have a General SCALER (GSCALER) IP block that can be used
> to do video streams scaling and color space conversions by hardware.
> Enable support for its driver as a module so the GSCALER can be tested.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)



Thanks, applied.

Best regards,
Krzysztof
