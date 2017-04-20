From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Apr 2017 16:36:17 +0200
Subject: [PATCH v4 02/11] clk: sunxi-ng: add support for DE2 CCU
In-Reply-To: <20170420140252.vd6aeeweshx2tdou@rob-hp-laptop>
References: <20170416120849.54542-1-icenowy@aosc.io>
 <20170416120849.54542-3-icenowy@aosc.io>
 <20170420140252.vd6aeeweshx2tdou@rob-hp-laptop>
Message-ID: <20170420143617.v6yemhjamqufbqwj@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Apr 20, 2017 at 09:02:53AM -0500, Rob Herring wrote:
> On Sun, Apr 16, 2017 at 08:08:40PM +0800, Icenowy Zheng wrote:
> > diff --git a/include/dt-bindings/clock/sun8i-de2.h b/include/dt-bindings/clock/sun8i-de2.h
> > new file mode 100644
> > index 000000000000..982c6d18c75b
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/sun8i-de2.h
> > @@ -0,0 +1,54 @@
> > +/*
> > + * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.io>
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPL or the X11 license, at your option. Note that this dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This file is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License as
> > + *     published by the Free Software Foundation; either version 2 of the
> > + *     License, or (at your option) any later version.
> > + *
> > + *     This file is distributed in the hope that it will be useful,
> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *     GNU General Public License for more details.
> > + *
> > + * Or, alternatively,
> > + *
> > + *  b) Permission is hereby granted, free of charge, to any person
> > + *     obtaining a copy of this software and associated documentation
> > + *     files (the "Software"), to deal in the Software without
> > + *     restriction, including without limitation the rights to use,
> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
> > + *     sell copies of the Software, and to permit persons to whom the
> > + *     Software is furnished to do so, subject to the following
> > + *     conditions:
> > + *
> > + *     The above copyright notice and this permission notice shall be
> > + *     included in all copies or substantial portions of the Software.
> > + *
> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > + *     OTHER DEALINGS IN THE SOFTWARE.
> > + */
> 
> You can use SPDX tag here:
> 
> SPDX-License-Identifier: (GPL-2.0+ OR MIT)

I don't think you ever addressed Russell's comment about what would
happen to the license if and when the SPDX doc is changed or goes
offline?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170420/a8b92e0c/attachment-0001.sig>
