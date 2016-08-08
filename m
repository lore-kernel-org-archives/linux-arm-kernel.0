From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 08 Aug 2016 17:28:31 +0200
Subject: [PATCH] arm64: defconfig: enable xhci-platform
In-Reply-To: <1468929871-20523-1-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Tue, 19 Jul 2016 14:04:31 +0200")
References: <1468929871-20523-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87h9avuvog.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On Tue, Jul 19 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Some ARM64 platforms (for example the Marvell Armada 7K/8K) use the
> generic XHCI platform driver, so it makes sense to enable
> CONFIG_USB_XHCI_PLATFORM=y in the defconfig to support XHCI on such
> platforms.
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
> index fd2d74d..2bcd502 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -225,6 +225,7 @@ CONFIG_SND_SOC_AK4613=y
>  CONFIG_USB=y
>  CONFIG_USB_OTG=y
>  CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_PLATFORM=y
>  CONFIG_USB_XHCI_RCAR=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_MSM=y
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
