From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 13 May 2015 03:27:38 +0900
Subject: [GIT PULL] ARM: EXYNOS: dts: DTS fixes for 4.1, second try
In-Reply-To: <1431313819-16843-1-git-send-email-k.kozlowski@samsung.com>
References: <1431313819-16843-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5552461A.6070304@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/15 12:10, Krzysztof Kozlowski wrote:
> Dear Kukjin,
> 
> This groups one fix missed in your last pull requst. This fixes suspend
> on Peach boards related to Marvell mwifiex driver. The driver was
> enabled for Exynos defconfig during merge window so currently
> the suspend on these boards on this config fails.
> 
Yes, you're right. Only exynos5250-snow related patch has been fixed
before and this should be sent to upstream together. I've applied this
into samsung-fixes-2 with your signed-off-by.

Note this will be sent to arm-soc before a couple of days of -rc4 with
your other fix for suspend on exynos4.

Thanks,
Kukjin

> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 77b0ffdc4bbd267e9589aa025047e512322fc643:
> 
>   Merge branch 'v4.2-next/dt-samsung' into for-next (2015-05-09 04:03:46 +0900)
> 
> are available in the git repository at:
> 
> 
>   https://github.com/krzk/linux.git tags/samsung-dt-fixes-4.1-2
> 
> for you to fetch changes up to 2495ae559826c60e3ccde9850e3b38815725b9c9:
> 
>   ARM: dts: Add keep-power-in-suspend to WiFi SDIO node for Peach Boards (2015-05-11 11:00:00 +0900)
> 
> ----------------------------------------------------------------
> Fix for suspend on Peach boards related to Marvell mwifiex driver.
> The driver was enabled for Exynos defconfig during 4.1 merge window
> so currently the suspend on these boards on this config fails.
> 
> ----------------------------------------------------------------
> Javier Martinez Canillas (1):
>       ARM: dts: Add keep-power-in-suspend to WiFi SDIO node for Peach Boards
> 
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 1 +
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 1 +
>  2 files changed, 2 insertions(+)
