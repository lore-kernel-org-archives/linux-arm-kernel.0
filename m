From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Feb 2017 11:41:40 -0600
Subject: [PATCH 2/2] ARM64: dts: meson-gxl: Add support for HwaCom AmazeTV
In-Reply-To: <4f0d36ce-8b44-06f1-2dc1-6b681b80a685@suse.de>
References: <20170212193247.22705-1-carlo@caione.org>
 <20170212193247.22705-3-carlo@caione.org>
 <20170222144406.zycqtc77dygavh3q@rob-hp-laptop>
 <4f0d36ce-8b44-06f1-2dc1-6b681b80a685@suse.de>
Message-ID: <CAL_JsqJo7QCUrMc-DdbSpy=yxrkjBShcE+mo_ZuatUnwjWKd7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 8:49 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 22.02.2017 um 15:44 schrieb Rob Herring:
>> On Sun, Feb 12, 2017 at 08:32:47PM +0100, Carlo Caione wrote:
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-hwacom-amazetv.dts
>>> new file mode 100644
>>> index 0000000..4499789
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-hwacom-amazetv.dts
>>> @@ -0,0 +1,201 @@
>>> +/*
>>> + * Copyright (c) 2017 Carlo Caione
>>> + * Copyright (c) 2016 Andreas F?rber
>
> You can drop me here, Carlo.
>
>>> + * Copyright (c) 2016 BayLibre, Inc.
>>> + * Author: Neil Armstrong <narmstrong@kernel.org>
>>> + *
>>> + * This file is dual-licensed: you can use it either under the terms
>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>> + * licensing only applies to this file, and not this project as a
>>> + * whole.
>>> + *
>>> + *  a) This library is free software; you can redistribute it and/or
>>> + *     modify it under the terms of the GNU General Public License as
>>> + *     published by the Free Software Foundation; either version 2 of the
>>> + *     License, or (at your option) any later version.
>>> + *
>>> + *     This library is distributed in the hope that it will be useful,
>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *     GNU General Public License for more details.
>>> + *
>>> + * Or, alternatively,
>>> + *
>>> + *  b) Permission is hereby granted, free of charge, to any person
>>> + *     obtaining a copy of this software and associated documentation
>>> + *     files (the "Software"), to deal in the Software without
>>> + *     restriction, including without limitation the rights to use,
>>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>> + *     sell copies of the Software, and to permit persons to whom the
>>> + *     Software is furnished to do so, subject to the following
>>> + *     conditions:
>>> + *
>>> + *     The above copyright notice and this permission notice shall be
>>> + *     included in all copies or substantial portions of the Software.
>>> + *
>>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + *     OTHER DEALINGS IN THE SOFTWARE.
>>> + */
>>
>> I'm going to start asking people to use SPDX tags and you are the first. :)
>
> Fine with me, I'll update my in-flight series. But:
>
>>
>> SPDX-License-Identifier: GPL2.0+ OR MIT
>
> I'm fairly sure that it's GPL-2.0+ with a dash.

Oh yes. Just making sure people are paying attention. ;)

I think it needs parenthesis around it, too.

Rob
