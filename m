From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 9 May 2016 10:30:38 +0200
Subject: [PATCH 3/4] ARM: mxs: dts: Add Creative X-Fi3 support
In-Reply-To: <572FA04B.1020005@denx.de>
References: <1462479971-7891-1-git-send-email-marex@denx.de>
 <1462479971-7891-3-git-send-email-marex@denx.de>
 <977436072.210446.e7eef450-2262-47df-8e8e-6a44da10083c.open-xchange@email.1und1.de>
 <572FA04B.1020005@denx.de>
Message-ID: <57304AAE.20103@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 08.05.2016 um 22:23 schrieb Marek Vasut:
> On 05/06/2016 09:40 AM, Stefan Wahren wrote:
>> Hi Marek,
> Hi!
>
>> sorry for the reply format.
> replying from a phone ? :)

no an ugly webmailer :(

>
>>> Marek Vasut <marex@denx.de> hat am 5. Mai 2016 um 22:26 geschrieben:
>>>
>>> Add support for this small MP3 player based on STMP3780 (rev.4).
>>> Currently supported is both external microSD and internal SD-NAND
>>> bridge, PWM and USB gadget.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>>> Cc: Shawn Guo <shawnguo@kernel.org>
>>> ---
>>>  arch/arm/boot/dts/Makefile | 1 +
>>>  arch/arm/boot/dts/imx23-xfi3.dts | 190
>>> +++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 191 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/imx23-xfi3.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index 8f9f1c2..7a79d37 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -417,6 +417,7 @@ dtb-$(CONFIG_ARCH_MXS) += \
>>>  imx23-evk.dtb \
>>>  imx23-olinuxino.dtb \
>>>  imx23-stmp378x_devb.dtb \
>>> + imx23-xfi3.dtb \
>>>  imx28-apf28.dtb \
>>>  imx28-apf28dev.dtb \
>>>  imx28-apx4devkit.dtb \
>>> diff --git a/arch/arm/boot/dts/imx23-xfi3.dts
>>> b/arch/arm/boot/dts/imx23-xfi3.dts
>>> new file mode 100644
>>> index 0000000..d7e7cf5
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/imx23-xfi3.dts
>>> @@ -0,0 +1,190 @@
>>> +/*
>>> + * Copyright (C) 2013-2016 Marek Vasut <marex@denx.de>
>>> + *
>>> + * This file is dual-licensed: you can use it either under the terms
>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>> + * licensing only applies to this file, and not this project as a
>>> + * whole.
>>> + *
>>> + * a) This file is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License as
>>> + * published by the Free Software Foundation; either version 2 of
>>> + * the License, or (at your option) any later version.
>>> + *
>>> + * This file is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public
>>> + * License along with this file; if not, write to the Free
>>> + * Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
>>> + * MA 02110-1301 USA
>> AFAIK this address shouldn't be included.
> Hmmm, some boards do include it. I'll remove it from this submission and
> also for the xfi.
>
> Shall I send patch(es) removing the address from the other boards too ?

i'm not sure. Maybe Shawn has an opinion about it.

Thanks
Stefan
