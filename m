From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Jan 2017 16:58:21 +0100
Subject: [PATCH] arm64: defconfig: enable XORv2 for Marvell Armada 7K/8K
In-Reply-To: <1482420258-13888-1-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Thu, 22 Dec 2016 16:24:18 +0100")
References: <1482420258-13888-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87r34kf84i.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On jeu., d?c. 22 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> This commit enables the XORv2 DMA driver, which is used on the ARM64
> Marvell Armada 7K and 8K platforms.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied on mvebu/defconfig64

Thanks,

Gregory
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index dab2cb0..f8b6435 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -371,6 +371,7 @@ CONFIG_RTC_DRV_TEGRA=y
>  CONFIG_RTC_DRV_XGENE=y
>  CONFIG_RTC_DRV_S3C=y
>  CONFIG_DMADEVICES=y
> +CONFIG_MV_XOR_V2=y
>  CONFIG_PL330_DMA=y
>  CONFIG_TEGRA20_APB_DMA=y
>  CONFIG_QCOM_BAM_DMA=y
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
