From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Thu, 26 May 2016 16:26:00 +0200
Subject: [PATCH 2/2] ARM: dts: imx6q: add support for the Utilite Pro
In-Reply-To: <a6cc6b85d2fa4994b3cb7e2b047f800d@rwthex-w2-b.rwth-ad.de>
References: <1463957258-4893-1-git-send-email-christopher.spinrath@rwth-aachen.de>
 <c4ab0387041f42ada68296141befe332@rwthex-s1-b.rwth-ad.de>
 <CAOMZO5C5goJUdHKB9a=eOv9TKDkJWxnkWWb-G7E5Kvceg6sZVg@mail.gmail.com>
 <a6cc6b85d2fa4994b3cb7e2b047f800d@rwthex-w2-b.rwth-ad.de>
Message-ID: <9d7793850de942cfb578b0aeb2728f41@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

On 05/26/2016 10:28 AM, Igor Grinberg wrote:
> Hi Fabio,
> 
> On 05/23/2016 08:49 PM, Fabio Estevam wrote:
>> On Sun, May 22, 2016 at 7:47 PM,  <christopher.spinrath@rwth-aachen.de> wrote:
>>
>>> diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
>>> new file mode 100644
>>> index 0000000..bcd8e0d
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
>>> @@ -0,0 +1,128 @@
>>> +/*
>>> + * Copyright 2016 Christopher Spinrath
>>> + * Copyright 2013 CompuLab Ltd.
>>> + *
>>> + * Based on the GPLv2 licensed devicetree distributed with the vendor
>>> + * kernel for the Utilite Pro:
>>> + *     Copyright 2013 CompuLab Ltd.
>>> + *     Author: Valentin Raevsky <valentin@compulab.co.il>
>>> + *
>>> + * The code contained herein is licensed under the GNU General Public
>>> + * License. You may obtain a copy of the GNU General Public License
>>> + * Version 2 or later at the following locations:
>>
>> Can you make this dual GPL/X11 license?
>>
>> For reference take a look at:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/imx6sl-warp.dts?id=refs/tags/v4.6
> 
> Please excuse me my ignorance, what is the rationale for this change?
> 

Thanks for joining this discussion. I *guess* the rationale is to share
the same device tree with projects that are incompatible with the GPL
(e.g. *BSD). Even if there is no support for a particular device/board
having all (or most) files dual licensed makes it easier to just pull
them all in.

Cheers,
Christopher
