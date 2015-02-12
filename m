From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 Feb 2015 08:04:29 -0800
Subject: [PATCH 4/4] ARM: dts: omap3-pandora: include in dts Makefile
In-Reply-To: <1423746226-700-5-git-send-email-marek@goldelico.com>
References: <1423746226-700-1-git-send-email-marek@goldelico.com>
 <1423746226-700-5-git-send-email-marek@goldelico.com>
Message-ID: <20150212160429.GM2531@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Belisko <marek@goldelico.com> [150212 05:07]:
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 91bd5bd..69f3106 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -343,6 +343,8 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
>  	omap3-overo-storm-tobi.dtb \
>  	omap3-overo-summit.dtb \
>  	omap3-overo-tobi.dtb \
> +	omap3-pandora-600mhz.dtb \
> +	omap3-pandora-1ghz.dtb \
>  	omap3-sbc-t3517.dtb \
>  	omap3-sbc-t3530.dtb \
>  	omap3-sbc-t3730.dtb \

This change you can fold into patches 3 and 4 :)

Regards,

Tony
