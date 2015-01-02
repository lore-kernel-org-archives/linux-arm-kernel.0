From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 2 Jan 2015 11:27:55 +0100
Subject: [PATCH 2/2] ARM: Add mediatek SoC UART support in defconfig
In-Reply-To: <1419587701-13451-3-git-send-email-eddie.huang@mediatek.com>
References: <1419587701-13451-1-git-send-email-eddie.huang@mediatek.com>
 <1419587701-13451-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <CABuKBeLJBjvjYs18b45f6LY33EyofRVJX8Fj2dTEtLpT3F7ZKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-12-26 10:55 GMT+01:00 Eddie Huang <eddie.huang@mediatek.com>:
> Add mediatek SoC UART support in multi_v7_defconfig
>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 2328fe7..fd0ff95 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -195,6 +195,7 @@ CONFIG_SERIO_AMBAKMI=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_8250_DW=y
> +CONFIG_SERIAL_8250_MT6577=y
>  CONFIG_SERIAL_AMBA_PL011=y
>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
>  CONFIG_SERIAL_MESON=y
> --
> 1.8.1.1

Applied, thanks.

>
> ************* Email Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!



-- 
motzblog.wordpress.com
