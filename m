From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 13 Oct 2017 09:58:23 +0100
Subject: [PATCH] arm64: defconfig: Enable hisilicon hibmc drm driver
In-Reply-To: <1503408056-177861-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1503408056-177861-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <59E0802F.3070904@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kefeng,

On 2017/8/22 14:20, Kefeng Wang wrote:
> Enable DRM_HISI_HIBMC as module for Hisilicon D03/D05 board.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Applied into hisilicon defconfig tree.
Thanks!

BR,
Wei

>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index b4ca115..f4d2a8e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -365,6 +365,7 @@ CONFIG_DRM_TEGRA=m
>  CONFIG_DRM_PANEL_SIMPLE=m
>  CONFIG_DRM_I2C_ADV7511=m
>  CONFIG_DRM_VC4=m
> +CONFIG_DRM_HISI_HIBMC=m
>  CONFIG_DRM_HISI_KIRIN=m
>  CONFIG_DRM_MESON=m
>  CONFIG_FB=y
> 
