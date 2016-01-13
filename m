From: holgerschurig@gmail.com (Holger Schurig)
Date: Wed, 13 Jan 2016 08:35:28 +0100
Subject: [PATCH 1/3] ARM: dts: imx6: add support for Ka-Ro electronics
 TX6S-8034 module
In-Reply-To: <1452621710-15336-2-git-send-email-LW@KARO-electronics.de>
 ("Lothar \=\?utf-8\?Q\?Wa\=C3\=9Fmann\=22's\?\= message of "Tue, 12 Jan 2016
 19:01:48 +0100")
References: <1452621710-15336-1-git-send-email-LW@KARO-electronics.de>
 <1452621710-15336-2-git-send-email-LW@KARO-electronics.de>
Message-ID: <87h9iigce7.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lothar Wa?mann <LW@KARO-electronics.de> writes:

> +/ {
> +	model = "Ka-Ro electronics TX6S-8034 Module";
> +	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
> +	timestamp = __DATE__, __TIME__;

Is this needed or useful?

There's a movement that aims to do "reproducible builds" ...   being
able to recompile an image and verify it against the supplied can be
helpful for security audit purposes.


> +	display: display at di0 {
> +		compatible = "fsl,imx-parallel-display";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_disp0_1>;
> +		interface-pix-fmt = "rgb24";
> +//		fsl,panel = <&lcd0_panel>;

Probably not for upstream inclusion?
