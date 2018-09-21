From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 21 Sep 2018 15:05:04 +0100
Subject: [PATCH] arm64: defconfig: enable HiSilicon HNS3 driver
In-Reply-To: <1536836203-173901-1-git-send-email-wangzhou1@hisilicon.com>
References: <1536836203-173901-1-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <5BA4FA90.1060607@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhou,

On 2018/9/13 11:56, Zhou Wang wrote:
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>

Thanks!
Applied to the hisilicon defconfig tree.

Best Regards,
Wei

> ---
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index db8d364..101ad54 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -222,6 +222,9 @@ CONFIG_THUNDER_NIC_PF=y
>  CONFIG_HIX5HD2_GMAC=y
>  CONFIG_HNS_DSAF=y
>  CONFIG_HNS_ENET=y
> +CONFIG_HNS3=y
> +CONFIG_HNS3_HCLGE=y
> +CONFIG_HNS3_ENET=y
>  CONFIG_E1000E=y
>  CONFIG_IGB=y
>  CONFIG_IGBVF=y
> 
