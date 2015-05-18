From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 18 May 2015 07:58:44 +0200
Subject: [PATCH 1/2] ARM: dts: nitrogen6x: use simple-panel instead of
 display-timings for LVDS0
In-Reply-To: <1431804202-11067-2-git-send-email-eric.nelson@boundarydevices.com>
References: <1431804202-11067-1-git-send-email-eric.nelson@boundarydevices.com>
 <1431804202-11067-2-git-send-email-eric.nelson@boundarydevices.com>
Message-ID: <20150518075844.7e1b5916@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Also add alias for backlight_lvds and connect it to the display.
> 
> Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
> ---
>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> index fd096dc..712c5ec 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> @@ -122,7 +122,7 @@
>  		status = "okay";
>  	};
>  
> -	backlight_lvds {
> +	backlight_lvds: backlight_lvds {
>
The patch does not add an 'alias', but a 'label'.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
