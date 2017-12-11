From: Wenyou.Yang@Microchip.com (Yang, Wenyou)
Date: Mon, 11 Dec 2017 09:33:37 +0800
Subject: [PATCH v8 2/2] media: i2c: Add the ov7740 image sensor driver
In-Reply-To: <CAOFm3uFASPpuMtGSetcYME0pQEmuzoLqY=Yhv5aaFu5AzJwaew@mail.gmail.com>
References: <20171208015542.15444-1-wenyou.yang@microchip.com>
 <20171208015542.15444-3-wenyou.yang@microchip.com>
 <CAOFm3uFASPpuMtGSetcYME0pQEmuzoLqY=Yhv5aaFu5AzJwaew@mail.gmail.com>
Message-ID: <d51138eb-0a59-034f-9810-dd72a1690ea2@Microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,


On 2017/12/8 21:14, Philippe Ombredanne wrote:
> Wenyou,
>
> On Fri, Dec 8, 2017 at 2:55 AM, Wenyou Yang <wenyou.yang@microchip.com> wrote:
>> The ov7740 (color) image sensor is a high performance VGA CMOS
>> image snesor, which supports for output formats: RAW RGB and YUV
>> and image sizes: VGA, and QVGA, CIF and any size smaller.
>>
>> Signed-off-by: Songjun Wu <songjun.wu@microchip.com>
>> Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
> []
>> --- /dev/null
>> +++ b/drivers/media/i2c/ov7740.c
>> @@ -0,0 +1,1226 @@
>> +/*
>> + * Copyright (c) 2017 Microchip Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License version
>> + * 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + */
> Have you considered using the new SPDX ids instead of this fine legalese?
> e.g.:
>
> // SPDX-License-Identifier: GPL-2.0
> // Copyright (c) 2017 Microchip Corporation.
>
> Short and neat! Check also Thomas doc patches and Linus comments on
> why he prefers the C++ comment style for these.
Thank you for your suggestion and information.


Best Regards,
Wenyou Yang
