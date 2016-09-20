From: joel@jms.id.au (Joel Stanley)
Date: Tue, 20 Sep 2016 16:52:03 +0930
Subject: [PATCH v3 2/3] ARM: aspeed: Add defconfigs for
 CONFIG_ASPEED_BT_IPMI_BMC
In-Reply-To: <1474354900-5618-3-git-send-email-clg@kaod.org>
References: <1474354900-5618-1-git-send-email-clg@kaod.org>
 <1474354900-5618-3-git-send-email-clg@kaod.org>
Message-ID: <CACPK8XdtaoMqVc-x3cc6Tp9hfWfXiGFJk2aPYjYMinE=EqFH2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 4:31 PM, C?dric Le Goater <clg@kaod.org> wrote:
> Signed-off-by: C?dric Le Goater <clg@kaod.org>

Acked-by: Joel Stanley <joel@jms.id.au>

I'll this in my tree to send to Arnd.

Cheers,

Joel
> ---
>
>  Changes since v1:
>
>  - renamed config option
>
>  arch/arm/configs/aspeed_g4_defconfig | 1 +
>  arch/arm/configs/aspeed_g5_defconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
> index ca39c04fec6b..af3847db00f8 100644
> --- a/arch/arm/configs/aspeed_g4_defconfig
> +++ b/arch/arm/configs/aspeed_g4_defconfig
> @@ -53,6 +53,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=6
>  CONFIG_SERIAL_8250_EXTENDED=y
>  CONFIG_SERIAL_8250_SHARE_IRQ=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_ASPEED_BT_IPMI_BMC=y
>  # CONFIG_HW_RANDOM is not set
>  # CONFIG_USB_SUPPORT is not set
>  # CONFIG_IOMMU_SUPPORT is not set
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
> index 4f366b0370e9..5d46290736fb 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -54,6 +54,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=6
>  CONFIG_SERIAL_8250_EXTENDED=y
>  CONFIG_SERIAL_8250_SHARE_IRQ=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_ASPEED_BT_IPMI_BMC=y
>  # CONFIG_HW_RANDOM is not set
>  # CONFIG_USB_SUPPORT is not set
>  # CONFIG_IOMMU_SUPPORT is not set
> --
> 2.7.4
>
