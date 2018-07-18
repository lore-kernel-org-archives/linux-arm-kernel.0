From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 18 Jul 2018 16:39:10 +0100
Subject: [PATCH] arm64: defconfig: enable Huawei Intelligent PCIe NIC
 driver
In-Reply-To: <1530067895-195886-1-git-send-email-wangzhou1@hisilicon.com>
References: <1530067895-195886-1-git-send-email-wangzhou1@hisilicon.com>
Message-ID: <5B4F5F1E.4060707@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhou,

On 2018/6/27 3:51, Zhou Wang wrote:
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index be36e61..fc6628f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -223,6 +223,7 @@ CONFIG_THUNDER_NIC_PF=y
>  CONFIG_HIX5HD2_GMAC=y
>  CONFIG_HNS_DSAF=y
>  CONFIG_HNS_ENET=y
> +CONFIG_HINIC=y

Since HINIC is a PCIe card and its default value is module,
I prefer to keep it what it was.
How do you think about it?
Thanks!

Best Regards,
Wei


>  CONFIG_E1000E=y
>  CONFIG_IGB=y
>  CONFIG_IGBVF=y
> 
