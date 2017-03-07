From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Mar 2017 18:09:09 +0100
Subject: [PATCH v8 6/6] arm64: dts: allwinner: h5: add support for the
 Orange Pi PC 2 board
In-Reply-To: <20170306214904.o2zpw3q3fvtrmsmd@localhost>
References: <20170306171750.7491-1-icenowy@aosc.xyz>
 <20170306171750.7491-7-icenowy@aosc.xyz>
 <20170306214904.o2zpw3q3fvtrmsmd@localhost>
Message-ID: <20170307170909.qnjy36yxbz5eiwe4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 10:49:05PM +0100, Rask Ingemann Lambertsen wrote:
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> > new file mode 100644
> > index 000000000000..30639729920d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> > @@ -0,0 +1,163 @@
> > +/*
> > + * Copyright (C) 2016 ARM Ltd.
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPL or the X11 license, at your option. Note that this dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> 
> I didn't catch any sort of announcement of it, but it seems as if we've
> started using SPDX license identifiers in dts files. Thus you can simply
> include the line
> SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> after the copyright notice and omit the license notices themselves. Even
> though the comment refers to "the X11 license", the license text matches that
> associated with the MIT license identifier [1] rather than that of the X11
> license [2]. The same goes for patch 5/6.
> 
> [1] https://spdx.org/licenses/MIT.html#licenseText
> [2] https://spdx.org/licenses/X11.html#licenseText

For my opinion on the matter, see this mail from RMK:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/490649.html

If people want to use it, I'm okay with that, but I really don't want
to actively enforce it during the reviews.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170307/86bee1ea/attachment-0001.sig>
