From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 03 Nov 2015 09:58:02 +0300
Subject: [PATCH v4 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <5637FCCB.1060007@samsung.com>
References: <cover.1446122247.git.p.fedin@samsung.com>
 <f1fbd1a7877090f4318705f0fccbf4d96c0ebc9c.1446122247.git.p.fedin@samsung.com>
 <56330E6E.50003@samsung.com> <00d401d112ff$c426e9a0$4c74bce0$@samsung.com>
 <5635D1EE.5010604@samsung.com> <012101d11540$8c280be0$a47823a0$@samsung.com>
 <5637FCCB.1060007@samsung.com>
Message-ID: <004d01d11604$fc7a2a80$f56e7f80$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> >>> --- cut exynos5410.dtsi ---
> >>> 		sromc: sromc at 12250000 {
> >>> 			#address-cells = <2>;
> >>> 			#size-cells = <1>;
> >>> 			ranges = <0 0 0x04000000 0x20000
> >>> 				  1 0 0x05000000 0x20000
> >>> 				  2 0 0x06000000 0x20000
> >>> 				  3 0 0x07000000 0x20000>;
> >>
> >> Do you have to use 2 cells for address? Cannot it be:
> >>  			ranges = <0 0x04000000 0x20000
> >>  				  1 0x05000000 0x20000
> >>  				  2 0x06000000 0x20000
> >>  				  3 0x07000000 0x20000>;
> >
> >  I tried this first, but it didn't work, and ranges translation
> > gave me something really weird (like addr = 0x80 and
> > size = 0x04000004).
> 
> Did you change the address-cells to <1>?

 Of course i did.

 I don't quote the rest because i simply agree to what you've said. Will respin with these changes.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
