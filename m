From: stwiss.opensource@diasemi.com (Opensource [Steve Twiss])
Date: Tue, 26 Aug 2014 10:54:59 +0000
Subject: [RESEND PATCH V2] devicetree: Dialog Semiconductor consolidate
 existing vendor prefixes to standardise on 'dlg'
In-Reply-To: <20140826093312.GI9574@lee--X1>
References: <201408221446.s7MEkNVF001775@swsrvapps-01.diasemi.com>
 <20140826093312.GI9574@lee--X1>
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7D0B39744@SW-EX-MBX02.diasemi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 August 2014 10:33 Lee Jones wrote:

> On Fri, 22 Aug 2014, Opensource [Steve Twiss] wrote:
> > From: Steve Twiss <stwiss.opensource@diasemi.com>
> >
> > This patch series updates the device tree vendor prefix for
> > Dialog Semiconductor.
> >

[...]

> > I think this is it. But, if I am missing anything or there are problems, can
> > I get a quick explanation in the reply so I can fix it and move forwards
> > please?
> >
> > In full:
> > Acked-by the following people so far:
> 
> When you say "so far", does that mean you're missing Acks still?

Hi Lee,

Apologies for my "so far" -- that is just my wording.

As I understand it I have all the Acks that are necessary. I am basing my Acks list on
the get_maintainers script output and on a previous request for Renesas and 
Freescale inputs -- which I have also got.
I do not see any mistakes or missing entries from my part.

> 
> If you have the full-set I will apply this and send out the necessary
> pull-request(s).
> 

Yes please.

Regards,
Steve

ps. for reference,  this is my justification for all files in the patch.

./drivers/mfd/da9055-core.c
	Support Opensource <support.opensource@diasemi.com> (supporter:DIALOG SEMICONDUC...)
	Lee Jones <lee.jones@linaro.org> (supporter:MULTIFUNCTION DEV...,commits:3/8=38%)

./Documentation/devicetree/bindings/regulator/da9210.txt.get_maintainer
	Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND...)
	S Twiss <stwiss.opensource@diasemi.com> (authored lines:2/21=10%)

./arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi.get_maintainer
	Shawn Guo <shawn.guo@freescale.com> (maintainer:ARM/FREESCALE IMX...,authored lines:276/279=99%,commits:6/7=86%)
	Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND...)

./arch/arm/boot/dts/imx53-smd.dts.get_maintainer
	Shawn Guo <shawn.guo@freescale.com> (maintainer:ARM/FREESCALE IMX...,authored lines:276/279=99%,commits:6/7=86%)
	Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND...)

./arch/arm/boot/dts/r8a7791-koelsch.dts.get_maintainer
	Simon Horman <horms@verge.net.au> (supporter:ARM/SHMOBILE ARM...,commits:25/26=96%)
	Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND...)

./arch/arm/boot/dts/r8a7790-lager.dts.get_maintainer
	Simon Horman <horms@verge.net.au> (supporter:ARM/SHMOBILE ARM...,commits:25/26=96%)
	Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND...)

./Documentation/devicetree/bindings/vendor-prefixes.txt.get_maintainer
	Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND...,commits:40/78=51%)

./Documentation/devicetree/bindings/i2c/trivial-devices.txt.get_maintainer
	Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND...)
