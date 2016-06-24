From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 24 Jun 2016 12:16:42 +0200
Subject: [PATCH v3] ARM: dts: sun8i: Add dts file for Olimex A33-OLinuXino
In-Reply-To: <2618ba96-c3c5-4db6-b860-d212e7045f23@googlegroups.com>
References: <1466418769-8384-1-git-send-email-stefan.mavrodiev@gmail.com>
 <20160622132222.GX26668@lukather>
 <2618ba96-c3c5-4db6-b860-d212e7045f23@googlegroups.com>
Message-ID: <20160624101642.GC3785@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2016 at 04:07:13AM -0700, stefan.mavrodiev at gmail.com wrote:
> > > +&usb_otg {
> > > +	dr_mode = "host";
> > > +	status = "okay";
> > > +};
> > > +
> > > +&usbphy {
> > > +	usb0_vbus-supply = <&reg_vcc5v0>;
> > > +	status = "okay";
> > > +
> > > +};
> > 
> > It doesn't work as USB OTG ?
> > 
> 
> The hardware should work as OTG. In FEL mode it works as device, and
> in current dt configuration - as host. I've spend some time trying
> to make it work as otg, but didn't succeed.
> 
> There are some hardware differences between our board and other a33,
> but if you say that OTG work, I'll spend some additional time
> working on it.

Yes, I've been testing and got it to work on at least two other A33
boards (the R16 Parrot and the Sinlinx SinA33). You can look at the
Parrot DT, you should have everything you need (but you will most
likely need linux-next).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160624/aa0e7427/attachment-0001.sig>
