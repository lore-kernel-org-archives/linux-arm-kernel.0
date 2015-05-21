From: hs@denx.de (Heiko Schocher)
Date: Thu, 21 May 2015 07:20:41 +0200
Subject: [PATCH v3] arm, imx6, dts: add DT for aristainetos2 board
In-Reply-To: <20150521010424.GF24844@dragon>
References: <1432099863-8642-1-git-send-email-hs@denx.de>
 <1432118319.4466.40.camel@pengutronix.de> <555C6C72.2060302@denx.de>
 <20150521010424.GF24844@dragon>
Message-ID: <555D6B29.9060202@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

Am 21.05.2015 03:04, schrieb Shawn Guo:
> On Wed, May 20, 2015 at 01:13:54PM +0200, Heiko Schocher wrote:
>>>> + * Copyright (C) 2015 Heiko Schocher <hs@denx.de>
>>>> + *
>>>> + * This file is dual-licensed: you can use it either under the terms
>>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>>> + * licensing only applies to this file, and not this project as a
>>>> + * whole.
>>>> + *
>>>> + *  a) This file is free software; you can redistribute it and/or
>>>> + *     modify it under the terms of the GNU General Public License as
>>>> + *     published by the Free Software Foundation; either version 2 of
>>>> + *     the License, or (at your option) any later version.
>>>> + *
>>>> + *     This file is distributed in the hope that it will be useful,
>>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + *     GNU General Public License for more details.
>>>> + *
>>>> + *     You should have received a copy of the GNU General Public
>>>> + *     License along with this file; if not, write to the Free
>>>> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
>>>> + *     MA 02110-1301 USA
>>>
>>> checkpatch warns that you should not include this paragraph because the
>>> mail address might change in the future and it is contained in COPYING.
>>
>> Hmm... Shawn mentioned to change it to the "GPL/X11 dual licence"
>> as in the arch/arm/boot/dts/imx6sl-warp.dts file ... so I copied this
>> from there ... is there a better option for this?
>
> It seems I pointed you to a bad example.  Let me try again, see
> arch/arm/boot/dts/imx6q-hummingboard.dts for example.

Ok, changed, thanks!

Hmm.. why not using the SPDX license identifier? This would save a
lot of lines ...

I try the changes Philipp suggested for the 7" display (using the
panel-simple driver for it) and post a v4.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
