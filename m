From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Tue, 6 May 2014 09:37:12 +0200
Subject: [PATCH 1/2] ARM: dts: imx51-eukrea-mbimxsd51-baseboard: Add CAN
 support
In-Reply-To: <1399344401.373980656@f157.i.mail.ru>
References: <1399327248-17887-1-git-send-email-festevam@gmail.com>
 <1399344401.373980656@f157.i.mail.ru>
Message-ID: <20140506093712.308a579b@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 06 May 2014 06:46:41 +0400,
Alexander Shiyan <shc_work@mail.ru> a ?crit :

> Mon,  5 May 2014 19:00:47 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Add support for CAN based on a MPC2515 connected to ECSPI1.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> > Eric/Denis,
> > 
> > I don't have the hardware to test it. Please give it a test.
> > 
> >  .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  | 34 ++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
> > index 8b1098e..f0067e9 100644
> > --- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
> > +++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
> > @@ -86,6 +86,24 @@
> >  	status = "okay";
> >  };
> >  
> > +&ecspi1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_ecspi1>;
> > +	fsl,spi-num-chipselects = <1>;
> > +	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>;
> 
> Really CS High for this?
> I think this is wrong.
> 
yes this is wrong.

Eric
