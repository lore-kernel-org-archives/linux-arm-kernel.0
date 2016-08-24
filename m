From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 24 Aug 2016 16:15:46 +0100
Subject: [PATCH v2 0/3] arm64: defconfig: enable various configs for HiKey
In-Reply-To: <1472006527-30620-1-git-send-email-guodong.xu@linaro.org>
References: <1472006527-30620-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <57BDBA22.5080600@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guodong,

On 24/08/2016 03:42, Guodong Xu wrote:
> Enable various configs for HiKey, including:
> 1. HiSilicon Kirin DRM
> 2. ADV7533
> 3. HiSi Powerkey
> 4. Bluetooth
> 

Series applied to the hisilicon soc tree.
Thanks!

Best Regards,
Wei

> v2:
>  - Removed CMA size 128M change. Leave that in bootloader as suggested by
>    Thierry Reding <treding@nvidia.com>
> 
> Guodong Xu (3):
>   arm64: defconfig: Enable HiSilicon kirin drm, adv7533 for HiKey
>   arm64: defconfig: enable CONFIG_INPUT_HISI_POWERKEY for HiKey
>   arm64: defconfig: enable bluetooth supports as modules
> 
>  arch/arm64/configs/defconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
