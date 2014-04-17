From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 17 Apr 2014 08:39:12 +0200
Subject: [PATCH 9/10] ARM: dts: tx28: restructure and update DTS file
In-Reply-To: <1375281480-25775-9-git-send-email-LW@KARO-electronics.de>
References: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
 <1375281480-25775-9-git-send-email-LW@KARO-electronics.de>
Message-ID: <534F7710.8050801@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.07.2013 16:37, Lothar Wa?mann wrote:
>
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
...
> +&lcdif {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&lcdif_24bit_pins_a &lcdif_sync_pins_a &lcdif_ctrl_pins_a>;
> +       lcd-supply = <&reg_lcd>;
> +       display = <&display>;
> +       status = "okay";
> +
> +       display: display at 0 {
> +               bits-per-pixel = <32>;
> +               bus-width = <24>;
> +
> +               display-timings {
> +                       native-mode = <&timing5>;
> +                       timing0: timing0 {
> +                               panel-name = "VGA";
...

I've been looking for any user or documentation of 'panel-name'. But 
couldn't find anything. Anything I missed?

Many thanks

Dirk
