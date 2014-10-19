From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Oct 2014 21:17:56 +0200
Subject: [PATCHv5 1/6] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <20141019011744.GB7869@tiger>
References: <1413192963-11153-1-git-send-email-jingchang.lu@freescale.com>
 <1413192963-11153-2-git-send-email-jingchang.lu@freescale.com>
 <20141019011744.GB7869@tiger>
Message-ID: <2556316.vcmG00PcyL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 October 2014 09:17:46 Shawn Guo wrote:
> > diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> > new file mode 100644
> > index 0000000..5075c18
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/ls1021a.dtsi
> > @@ -0,0 +1,405 @@
> > +/*
> > + * Copyright 2013-2014 Freescale Semiconductor, Inc.
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPL or the X11 license, at your option. Note that this dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This library is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License as
> > + *     published by the Free Software Foundation; either version 2 of
> > + *     the License, or (at your option) any later version.
> > + *
> > + *     This library is distributed in the hope that it will be useful,
> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *     GNU General Public License for more details.
> > + *
> > + *     You should have received a copy of the GNU General Public
> > + *     License along with this library; if not, write to the Free
> > + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> > + *     MA 02110-1301 USA
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
> DT maintainers,
> 
> I would like to confirm this is a appropriate copyright for device tree
> sources, as it sets the example how we should migrate from the existing
> GPL.  If we merge it, I assume that a lot of future files will likely
> follow the example.

The license is fine as far as I can tell, but the first half mentions
'library' three times, and that should probably be changed to 'file'.

The Allwinner dts files had the same text and are now changing it to
say 'file'.

	Arnd
