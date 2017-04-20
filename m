From: robh@kernel.org (Rob Herring)
Date: Thu, 20 Apr 2017 17:36:31 -0500
Subject: [PATCH v4 02/11] clk: sunxi-ng: add support for DE2 CCU
In-Reply-To: <20170420143617.v6yemhjamqufbqwj@lukather>
References: <20170416120849.54542-1-icenowy@aosc.io>
 <20170416120849.54542-3-icenowy@aosc.io>
 <20170420140252.vd6aeeweshx2tdou@rob-hp-laptop>
 <20170420143617.v6yemhjamqufbqwj@lukather>
Message-ID: <CAL_JsqL=bKVX4MsqHE+Nhg9TnR6B25_-5RPW2chTsCjXudtFfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 9:36 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Rob,
>
> On Thu, Apr 20, 2017 at 09:02:53AM -0500, Rob Herring wrote:
>> On Sun, Apr 16, 2017 at 08:08:40PM +0800, Icenowy Zheng wrote:
>> > diff --git a/include/dt-bindings/clock/sun8i-de2.h b/include/dt-bindings/clock/sun8i-de2.h
>> > new file mode 100644
>> > index 000000000000..982c6d18c75b
>> > --- /dev/null
>> > +++ b/include/dt-bindings/clock/sun8i-de2.h
>> > @@ -0,0 +1,54 @@
>> > +/*
>> > + * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.io>
>> > + *
>> > + * This file is dual-licensed: you can use it either under the terms
>> > + * of the GPL or the X11 license, at your option. Note that this dual
>> > + * licensing only applies to this file, and not this project as a
>> > + * whole.
>> > + *
>> > + *  a) This file is free software; you can redistribute it and/or
>> > + *     modify it under the terms of the GNU General Public License as
>> > + *     published by the Free Software Foundation; either version 2 of the
>> > + *     License, or (at your option) any later version.
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
>> > + */
>>
>> You can use SPDX tag here:
>>
>> SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>
> I don't think you ever addressed Russell's comment about what would
> happen to the license if and when the SPDX doc is changed or goes
> offline?

Frankly, it's a copyright holders decision what they want to use. SPDX
is already used in the kernel. Look in the USB subsystem. SPDX is not
going anywhere and is endorsed by companies with well known legal
depts. If people want to argue about it still, then I've got better
things to do.

Rob
