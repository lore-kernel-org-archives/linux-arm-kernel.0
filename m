From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 18 Jan 2017 18:27:33 +0200
Subject: [PATCH v3] arm64: dts: exynos: Remove unneeded unit names in
 Exynos5433 nodes
In-Reply-To: <1484754613-2425-1-git-send-email-javier@osg.samsung.com>
References: <1484754613-2425-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20170118162733.rfnskad7iltojsda@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 12:50:13PM -0300, Javier Martinez Canillas wrote:
> The "samsung,exynos5433-mipi-video-phy" and "samsung,exynos5250-dwusb3"
> DT bindings don't specify a reg property for these nodes, so having a
> unit name leads to the following DTC warnings:
> 
> Node /soc/video-phy at 105c0710 has a unit name, but no reg property
> Node /soc/usb at 15400000 has a unit name, but no reg property
> Node /soc/usb at 15a00000 has a unit name, but no reg property
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
> Changes in v3:
>   - Use proper device node names, suggested by Krzysztof.
> 
> Changes in v2:
>   - Fix subject line since I forgot the "exynos" prefix.
> 
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, applied.

Best regards,
Krzysztof
