From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 26 May 2016 11:28:59 +0300
Subject: [PATCH 2/2] ARM: dts: imx6q: add support for the Utilite Pro
In-Reply-To: <CAOMZO5C5goJUdHKB9a=eOv9TKDkJWxnkWWb-G7E5Kvceg6sZVg@mail.gmail.com>
References: <1463957258-4893-1-git-send-email-christopher.spinrath@rwth-aachen.de>
 <c4ab0387041f42ada68296141befe332@rwthex-s1-b.rwth-ad.de>
 <CAOMZO5C5goJUdHKB9a=eOv9TKDkJWxnkWWb-G7E5Kvceg6sZVg@mail.gmail.com>
Message-ID: <5746B3CB.20804@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 05/23/2016 08:49 PM, Fabio Estevam wrote:
> On Sun, May 22, 2016 at 7:47 PM,  <christopher.spinrath@rwth-aachen.de> wrote:
> 
>> diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
>> new file mode 100644
>> index 0000000..bcd8e0d
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
>> @@ -0,0 +1,128 @@
>> +/*
>> + * Copyright 2016 Christopher Spinrath
>> + * Copyright 2013 CompuLab Ltd.
>> + *
>> + * Based on the GPLv2 licensed devicetree distributed with the vendor
>> + * kernel for the Utilite Pro:
>> + *     Copyright 2013 CompuLab Ltd.
>> + *     Author: Valentin Raevsky <valentin@compulab.co.il>
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
> 
> Can you make this dual GPL/X11 license?
> 
> For reference take a look at:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/imx6sl-warp.dts?id=refs/tags/v4.6

Please excuse me my ignorance, what is the rationale for this change?

-- 
Regards,
Igor.
