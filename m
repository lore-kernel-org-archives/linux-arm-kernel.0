From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 18 Jul 2018 16:36:49 +0100
Subject: [PATCH] arm64: defconfig: enable HiSilicon PMU driver
In-Reply-To: <1530067786-195470-1-git-send-email-wangzhou1@hisilicon.com>
References: <1530067786-195470-1-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <5B4F5E91.3000803@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhou,

On 2018/6/27 3:49, Zhou Wang wrote:
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>

Thanks!
Applied to the hisilicon defconfig tree.

Best Regards,
Wei

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 3cfa8ca..be36e61 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -633,6 +633,7 @@ CONFIG_PHY_ROCKCHIP_PCIE=m
>  CONFIG_PHY_ROCKCHIP_TYPEC=y
>  CONFIG_PHY_XGENE=y
>  CONFIG_PHY_TEGRA_XUSB=y
> +CONFIG_HISI_PMU=y
>  CONFIG_QCOM_L2_PMU=y
>  CONFIG_QCOM_L3_PMU=y
>  CONFIG_MESON_EFUSE=m
> 
