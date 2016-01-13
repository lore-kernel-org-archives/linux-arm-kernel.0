From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 13 Jan 2016 12:10:12 +0100
Subject: [PATCH 1/3] ARM: dts: imx6: add support for Ka-Ro electronics
 TX6S-8034 module
In-Reply-To: <87h9iigce7.fsf@gmail.com>
References: <1452621710-15336-1-git-send-email-LW@KARO-electronics.de>
 <1452621710-15336-2-git-send-email-LW@KARO-electronics.de>
 <87h9iigce7.fsf@gmail.com>
Message-ID: <20160113121012.0c924bc8@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Lothar Wa?mann <LW@KARO-electronics.de> writes:
> 
> > +/ {
> > +	model = "Ka-Ro electronics TX6S-8034 Module";
> > +	compatible = "karo,imx6dl-tx6dl", "fsl,imx6dl";
> > +	timestamp = __DATE__, __TIME__;
> 
> Is this needed or useful?
> 
> There's a movement that aims to do "reproducible builds" ...   being
> able to recompile an image and verify it against the supplied can be
> helpful for security audit purposes.
> 
Ooops. I was on the wrong branch when creating these patches. Will
resend this patch series soon.

> > +	display: display at di0 {
> > +		compatible = "fsl,imx-parallel-display";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_disp0_1>;
> > +		interface-pix-fmt = "rgb24";
> > +//		fsl,panel = <&lcd0_panel>;
> 
> Probably not for upstream inclusion?
>
see above.
