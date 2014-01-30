From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 30 Jan 2014 16:07:06 -0500
Subject: [PATCH 7/7] ARM: mvebu: enable audio options in mvebu_defconfig
In-Reply-To: <1391102051-5319-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1391102051-5319-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140130210706.GG29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 06:14:11PM +0100, Thomas Petazzoni wrote:
> Since at least the Armada 370 SoC has audio support, it makes sense to
> enable the corresponding kernel configuration options in
> mvebu_defconfig.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)

Please, let's also get in the habit of updating multi_v7_defconfig as
well.

thx,

Jason.

> diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
> index 594d706..e481f01 100644
> --- a/arch/arm/configs/mvebu_defconfig
> +++ b/arch/arm/configs/mvebu_defconfig
> @@ -60,6 +60,11 @@ CONFIG_GPIOLIB=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_THERMAL=y
>  CONFIG_ARMADA_THERMAL=y
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_SOC=y
> +CONFIG_SND_KIRKWOOD_SOC=y
> +CONFIG_SND_KIRKWOOD_SOC_ARMADA370_DB=y
>  CONFIG_USB_SUPPORT=y
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
> -- 
> 1.8.3.2
> 
