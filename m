From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 22 Dec 2017 11:40:28 +0100
Subject: [PATCH v2 4/5] ARM: dts: Add support for emtrion emCON-MX6 series
In-Reply-To: <95F51F4B902CAC40AF459205F6322F01B7FDFECC3C@BMK019S01.emtrion.local>
References: <95F51F4B902CAC40AF459205F6322F01B7FDFECC3C@BMK019S01.emtrion.local>
Message-ID: <20171222104028.GC18255@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22/12/2017 at 11:34:31 +0100, T?rk, Jan wrote:
> > > diff --git a/arch/arm/boot/dts/imx6q-emcon.dtsi b/arch/arm/boot/dts/imx6q-
> > emcon.dtsi
> > > new file mode 100644
> > > index 000000000000..64fc0cd74c05
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/imx6q-emcon.dtsi
> > > @@ -0,0 +1,37 @@
> > > +/*
> > > + * Copyright (C) 2017 emtrion GmbH
> > > + * Author: Jan Tuerk  <jan.tuerk@emtrion.com>
> > > + *
> > > + * The code contained herein is licensed under the GNU General Public
> > > + * License. You may obtain a copy of the GNU General Public License
> > > + * Version 2 or later at the following locations:
> > > + *
> > > + * http://www.opensource.org/licenses/gpl-license.html
> > > + * http://www.gnu.org/copyleft/gpl.html
> > 
> > You don't need this if...
> 
> I've got a little different point of view on this since the OSS Europe 2017 - part of gpl2 following.
> 
> GPLv2-Para1 (=>highlighted<=) :
> 1. You may copy and distribute verbatim copies of the Program's source code as you receive it, in any medium,
>  provided that you conspicuously and appropriately publish on each copy an 
> => appropriate copyright notice and disclaimer of warranty; <=
> keep intact all the notices that refer to this License and to the absence of any warranty;
>  and give any other recipients of the Program a copy of this License along with the Program.
> 
> After reviewing this I think apparently I should include the Warranty disclaimer as well.
> Examples could be found  in:
> arch/arm/boot/dts/imx6q-tbs2910.dts
> and
> arch/arm/boot/dts/imx6q-zii-rdu2.dts
> 

The license is already fully included in COPYING with the warranty
disclaimer.

> > 
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0
> > 
> > You have this.
> > 
> > Also, the rules around this are getting a bit stricter saying the SPDX
> > tag should be the first line of the file using a C++ style comment.
> > 
> I'll change it for v3 of this patch however it will end up like this:
> //SPDX-License...

That should be /* SPDX-License */, // is for c files.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
