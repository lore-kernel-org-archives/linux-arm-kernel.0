From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 06 Aug 2015 16:08:56 +0900
Subject: [RFC PATCH v4 5/9] arm: exynos_defconfig: remove
 CONFIG_MMC_DW_IDMAC
In-Reply-To: <1438843539-24017-1-git-send-email-shawn.lin@rock-chips.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843539-24017-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <55C30808.1020704@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.08.2015 15:45, Shawn Lin wrote:
> DesignWare MMC Controller's transfer mode should be decided
> at runtime instead of compile-time. So we remove this config
> option and read dw_mmc's register to select DMA master.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/configs/exynos_defconfig | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
