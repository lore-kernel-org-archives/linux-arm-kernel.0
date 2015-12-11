From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 11 Dec 2015 19:07:00 +0800
Subject: [PATCH V3 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <201512021641.31222.marex@denx.de>
References: <1448722024-5717-1-git-send-email-marex@denx.de>
 <1448722024-5717-2-git-send-email-marex@denx.de>
 <20151202075305.GN692@tiger> <201512021641.31222.marex@denx.de>
Message-ID: <20151211110700.GD11252@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 04:41:31PM +0100, Marek Vasut wrote:
> On Wednesday, December 02, 2015 at 08:53:05 AM, Shawn Guo wrote:
> > On Sat, Nov 28, 2015 at 03:47:04PM +0100, Marek Vasut wrote:
> > > +	reg_usb_otg_vbus: usb_otg_vbus {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "usb_otg_vbus";
> > > +		regulator-min-microvolt = <5000000>;
> > > +		regulator-max-microvolt = <5000000>;
> > > +		enable-active-high;
> > > +	};
> > 
> > All these regulator nodes are named so arbitrarily.  Can we name them a
> > bit consistently, something like regulator-xxx?
> 
> All of them are named like this (well, but the otg_vbus, I can fix that)
> 
> reg_something: something-regulator {}
> 
> What do you want to see here ?

reg_something: regulator-something {}

Shawn
