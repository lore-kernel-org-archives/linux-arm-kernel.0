From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 28 Feb 2017 17:49:57 -0600
Subject: [PATCH 3/4] arm: dts: imx: Add iMX6Q-based Kontron SMARC-sAMX6i
 module
In-Reply-To: <20170228231010.GD21222@n2100.armlinux.org.uk>
References: <20170219202801.2082-1-plaes@plaes.org>
 <20170219202801.2082-4-plaes@plaes.org>
 <CAL_JsqJzP5e0fcM==cqkAe=x9Yf+H7i+k1H0udaknY_h6cbOSQ@mail.gmail.com>
 <20170228231010.GD21222@n2100.armlinux.org.uk>
Message-ID: <CAL_Jsq+9EA72_Om4h3q3dGpDVAdkjDKsSkNU_S+3a81zaU73pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 5:10 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Feb 28, 2017 at 05:06:02PM -0600, Rob Herring wrote:
>> On Sun, Feb 19, 2017 at 2:28 PM, Priit Laes <plaes@plaes.org> wrote:
>> > SMARC-sAMX6i is a SMARC (Smart Mobility Architecture) compliant
>> > module.
>> >
>> > Signed-off-by: Priit Laes <plaes@plaes.org>
>> > ---
>> >  arch/arm/boot/dts/imx6q-smarc-sam6xi.dtsi | 434 ++++++++++++++++++++++++++++++
>> >  1 file changed, 434 insertions(+)
>> >  create mode 100644 arch/arm/boot/dts/imx6q-smarc-sam6xi.dtsi
>> >
>> > diff --git a/arch/arm/boot/dts/imx6q-smarc-sam6xi.dtsi b/arch/arm/boot/dts/imx6q-smarc-sam6xi.dtsi
>> > new file mode 100644
>> > index 0000000..e3d7a35
>> > --- /dev/null
>> > +++ b/arch/arm/boot/dts/imx6q-smarc-sam6xi.dtsi
>> > @@ -0,0 +1,434 @@
>> > +/*
>> > + * Copyright 2017 Priit Laes <plaes@plaes.org>
>> > + *
>> > + * Based on initial work by Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
>> > + *
>> > + * This file is dual-licensed: you can use it either under the terms
>> > + * of the GPL or the X11 license, at your option. Note that this dual
>> > + * licensing only applies to this file, and not this project as a
>> > + * whole.
>> > + *
>> > + *  a) This file is free software; you can redistribute it and/or
>> > + *     modify it under the terms of the GNU General Public License as
>> > + *     published by the Free Software Foundation; either version 2 of
>> > + *     the License, or (at your option) any later version.
>> > + *
>> > + *     This file is distributed in the hope that it will be useful,
>> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + *     GNU General Public License for more details.
>> > + *
>> > + * Or, alternatively,
>> > + *
>> > + *  b) Permission is hereby granted, free of charge, to any person
>> > + *     obtaining a copy of this software and associated documentation
>> > + *     files (the "Software"), to deal in the Software without
>> > + *     restriction, including without limitation the rights to use,
>> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> > + *     sell copies of the Software, and to permit persons to whom the
>> > + *     Software is furnished to do so, subject to the following
>> > + *     conditions:
>> > + *
>> > + *     The above copyright notice and this permission notice shall be
>> > + *     included in all copies or substantial portions of the Software.
>> > + *
>> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> > + *     OTHER DEALINGS IN THE SOFTWARE.
>>
>> Use SPDX tags here:
>>
>> SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>
>> While it says X11, this is really MIT license text.
>
> No.  Read the FSF's page on licenses:
>
>    X11 License (#X11License)
> ...
>            This license is sometimes called the MIT license, but that term is
>            misleading, since MIT has used many licenses for software.
>
> Never use the term "MIT license", it's ambiguous, and I doubt that such
> a term (given the above) would stand up in a court of law as identifying
> any particular license.

The SPDX tags have a very exact, documented meaning. That's the point.
X11 means this[1]. MIT means this[2].

Rob

[1] https://spdx.org/licenses/X11.html#licenseText
[2] https://spdx.org/licenses/MIT.html#licenseText
