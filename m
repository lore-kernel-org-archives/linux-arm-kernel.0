From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 23 Feb 2012 02:29:58 +0900
Subject: [PATCH v3] DMA: PL330: Merge PL330 driver into drivers/dma/
In-Reply-To: <CABb+yY0Zy3Xx4OZTobo2y-J4NXokGCV47PdPyKs+aOnqtng7pQ@mail.gmail.com>
References: <1329341243-14314-1-git-send-email-kgene.kim@samsung.com>	<CABb+yY1E0_ZhTv8QvRAfgUvc=2Vz+ioYbsEczknP5dKcL2ZCbw@mail.gmail.com>	<00f401ccf0f8$0db84ec0$2928ec40$%kim@samsung.com>	<CABb+yY0j0j7Qw4MCwP_F+DKzmpdmZ3x0QC2Ktj2qmGnL=Ocx0Q@mail.gmail.com>	<011c01ccf107$5624d020$026e7060$%kim@samsung.com>	<CABb+yY1aeZ9=2GiHni3bZuRjW66Mxz7K0M753Lc-6UdxaVpBzA@mail.gmail.com>	<1329906421.24656.93.camel@vkoul-udesk3>	<4F451D24.1040009@samsung.com>
 <CABb+yY0Zy3Xx4OZTobo2y-J4NXokGCV47PdPyKs+aOnqtng7pQ@mail.gmail.com>
Message-ID: <4F452616.30806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/12 02:20, Jassi Brar wrote:
> On Wed, Feb 22, 2012 at 10:21 PM, Kukjin Kim<kgene.kim@samsung.com>  wrote:
>>
>> * Copyright (c) 2012 Samsung Electronics Co., Ltd.
>> *               http://www.samsung.com
>> *
>> * Copyright (C) 2010 Samsung Electronics Co. Ltd.
>> *       Jaswinder Singh<jassi.brar@samsung.com>
>> *
> The following is more appropriate
>
> -  * Copyright (C) 2010 Samsung Electronics Co. Ltd.
> + * Copyright (C) 2010 - 2012 Samsung Electronics Co. Ltd.
>     *       Jaswinder Singh<jassi.brar@samsung.com>
>
Well, as I know, I don't have to change/update original your copyright. 
If required, you should do it, next time.

>
>> * Based on:
>> *       arch/arm/common/pl330.c, arch/arm/include/asm/hardware/pl330.h
>> *       Copyright (C) 2010 Samsung Electronics Co Ltd.
>>
> Doesn't make any sense because arch/arm/common/pl330.c
> and arch/arm/include/asm/hardware/pl330.h wouldn't exist anymore,
> and the changelog already provides that info.

OK, will not add above 'based on'.

I think you can agree following. Let's finish this talking.

* Copyright (c) 2012 Samsung Electronics Co., Ltd.
*		http://www.samsung.com
*
and 'original copyright'...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
