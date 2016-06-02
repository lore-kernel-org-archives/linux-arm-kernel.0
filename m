From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 02 Jun 2016 08:21:29 +0200
Subject: [PATCH v2] ARM: dts: exynos: Add TMU nodes regulator supply for
 Peach boards
In-Reply-To: <1464787235-8400-1-git-send-email-javier@osg.samsung.com>
References: <1464787235-8400-1-git-send-email-javier@osg.samsung.com>
Message-ID: <574FD069.8020709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 03:20 PM, Javier Martinez Canillas wrote:
> The Exynos5800 Peach Pi and Exynos5420 Peach Pit Chromebooks have the
> LDO10 1.8V output connected to the VDD18_TS{01,23,4} Exynos SoC pins.
> 
> Add this regulator as the input supply of the Thermal Management Unit
> channels and also remove the always-on property since all the devices
> using LDO10 as input supply are now defined.
> 
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
> Changes in v2:
> - Sorted nodes in alphabetical order (Krzysztof Kozlowski).
> - Added Krzysztof's Suggested-by tag since he mentioned in other
>   thread that the TMU supplies were missing.
> 
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 21 ++++++++++++++++++++-
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 21 ++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
