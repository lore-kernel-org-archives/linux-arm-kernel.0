From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 23 Mar 2017 19:13:18 +0800
Subject: [PATCH] ARM: dts: imx: add Gateworks Ventana GW5903 support
In-Reply-To: <CAL_JsqKVxpdS0cuXnwkux7zESXdjRA7RO0Pu0gGLdqKUTaMDpg@mail.gmail.com>
References: <1490125452-5712-1-git-send-email-tharvey@gateworks.com>
 <CAL_JsqKVxpdS0cuXnwkux7zESXdjRA7RO0Pu0gGLdqKUTaMDpg@mail.gmail.com>
Message-ID: <20170323111317.GA30608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 09:04:59AM -0500, Rob Herring wrote:
> > diff --git a/arch/arm/boot/dts/imx6dl-gw5903.dts b/arch/arm/boot/dts/imx6dl-gw5903.dts
> > new file mode 100644
> > index 0000000..103261e
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6dl-gw5903.dts
> > @@ -0,0 +1,55 @@
> > +/*
> > + * Copyright 2017 Gateworks Corporation
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPL or the X11 license, at your option. Note that this dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This file is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License as
> > + *     published by the Free Software Foundation; either version 2 of
> > + *     the License, or (at your option) any later version.
> > + *
> > + *     This file is distributed in the hope that it will be useful,
> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *     GNU General Public License for more details.
> > + *
> > + *     You should have received a copy of the GNU General Public
> > + *     License along with this file; if not, write to the Free
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
> You can use SPDX tag here:
> 
> SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> 
> While it says X11, this is really MIT license text as defined by SPDX.

Isn't it still controversial whether we should use SPDX tag or not?

https://lkml.org/lkml/2017/2/28/750

Shawn
