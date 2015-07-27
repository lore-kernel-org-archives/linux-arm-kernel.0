From: agross@codeaurora.org (Andy Gross)
Date: Mon, 27 Jul 2015 15:32:54 -0500
Subject: [PATCH v1 2/7] ARM: dts: ifc6410: add real regulators for sdcc
 nodes.
In-Reply-To: <1438005012-16263-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438004945-16175-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438005012-16263-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150727203254.GB12739@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 02:50:12PM +0100, Srinivas Kandagatla wrote:

<snip>

>  			sdcc3: sdcc at 12180000 {
>  				status = "okay";
> +				vmmc-supply = <&pm8921_l6>;
>  				pinctrl-names	= "default";
>  				pinctrl-0	= <&card_detect>;
>  				cd-gpios	= <&tlmm_pinmux 26 GPIO_ACTIVE_LOW>;
> @@ -187,6 +200,8 @@
>  			/* WLAN */
>  			sdcc4: sdcc at 121c0000 {
>  				status = "okay";
> +				vmmc-supply = <&ext_3p3v>;

Where is ext_3p3v defined?

> +				vqmmc-supply = <&pm8921_lvs1>;

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
