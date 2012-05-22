From: marex@denx.de (Marek Vasut)
Date: Tue, 22 May 2012 07:24:09 +0200
Subject: [PATCH v2 12/12] ARM: dts: imx28-evk: add usb devices
In-Reply-To: <20120522050345.GP6206@b20223-02.ap.freescale.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <20120522045240.GM8140@S2101-09.ap.freescale.net>
 <20120522050345.GP6206@b20223-02.ap.freescale.net>
Message-ID: <201205220724.09841.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Richard Zhao,

> On Tue, May 22, 2012 at 12:52:43PM +0800, Shawn Guo wrote:
> > On Mon, May 21, 2012 at 05:23:57PM +0800, Richard Zhao wrote:
> > >  	ahb at 80080000 {
> > > 
> > > +		usb0: usb at 80080000 {
> > > +			fsl,vbus-power = <&gpio3 9 0>;
> > 
> > fsl,vbus-power-gpios
> 
> Yes.
> 
> > > +			status = "okay";
> > > +		};
> > > +
> > > +		usb1: usb at 80090000 {
> > > +			fsl,vbus-power = <&gpio3 8 0>;
> > 
> > Ditto
> 
> Yes.
> 
> I'll test mx28 too next time before send out patch.
> Maybe need your help :)

I'm still stuck a bit with the DT conversion :-( I'll start testing ASAP.

> Thanks
> Richard
> 
> > > +			status = "okay";
> > > +		};
> > > +

Best regards,
Marek Vasut
