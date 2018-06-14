From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 14 Jun 2018 11:07:33 +0200
Subject: [PATCH 1/4] arm: dts: add support for Laird WB45N cpu module and
 DVK
In-Reply-To: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
References: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
Message-ID: <20180614090733.GV10521@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 14/06/2018 09:51:54+0100, Ben Whitten wrote:

This need a proper commit message. Maybe you can also add a link to the
technical brief for the platform?

> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
> ---
>  arch/arm/boot/dts/Makefile        |   3 +-
>  arch/arm/boot/dts/at91-wb45n.dts  |  66 +++++++++++++++
>  arch/arm/boot/dts/at91-wb45n.dtsi | 169 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 237 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/at91-wb45n.dts
>  create mode 100644 arch/arm/boot/dts/at91-wb45n.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e24249..1ee94ee 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -42,7 +42,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
>  	at91sam9g25ek.dtb \
>  	at91sam9g35ek.dtb \
>  	at91sam9x25ek.dtb \
> -	at91sam9x35ek.dtb
> +	at91sam9x35ek.dtb \
> +	at91-wb45n.dtb

The proper name for the file is <soc>-board.dtb so this should be
at91sam9g25-wb45n.dtb.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
