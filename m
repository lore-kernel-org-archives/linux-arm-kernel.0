From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 16:01:02 +0200
Subject: [PATCH] arm64: defconfig: Enable PL330 DMA controller
In-Reply-To: <1460465458-23533-1-git-send-email-alim.akhtar@samsung.com>
References: <1460465458-23533-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <570CFF9E.3010404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2016 02:50 PM, Alim Akhtar wrote:
> This patch enables PL330 DMA controller found on exynos7 SoCs.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/configs/defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f705051..60e5886 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -230,6 +230,7 @@ CONFIG_RTC_DRV_SUN6I=y
>  CONFIG_RTC_DRV_XGENE=y
>  CONFIG_DMADEVICES=y
>  CONFIG_QCOM_BAM_DMA=y
> +CONFIG_PL330_DMA=y
>  CONFIG_TEGRA20_APB_DMA=y
>  CONFIG_RCAR_DMAC=y
>  CONFIG_VFIO=y

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

If there are no objections, I can take it through samsung-soc tree.

Best regards,
Krzysztof
