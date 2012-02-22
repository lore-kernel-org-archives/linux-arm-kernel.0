From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 22 Feb 2012 23:10:25 +0530
Subject: [PATCH v3] DMA: PL330: Merge PL330 driver into drivers/dma/
In-Reply-To: <4F452616.30806@samsung.com>
References: <1329341243-14314-1-git-send-email-kgene.kim@samsung.com>
 <CABb+yY1E0_ZhTv8QvRAfgUvc=2Vz+ioYbsEczknP5dKcL2ZCbw@mail.gmail.com>
 <00f401ccf0f8$0db84ec0$2928ec40$%kim@samsung.com>
 <CABb+yY0j0j7Qw4MCwP_F+DKzmpdmZ3x0QC2Ktj2qmGnL=Ocx0Q@mail.gmail.com>
 <011c01ccf107$5624d020$026e7060$%kim@samsung.com>
 <CABb+yY1aeZ9=2GiHni3bZuRjW66Mxz7K0M753Lc-6UdxaVpBzA@mail.gmail.com>
 <1329906421.24656.93.camel@vkoul-udesk3>
 <4F451D24.1040009@samsung.com>
 <CABb+yY0Zy3Xx4OZTobo2y-J4NXokGCV47PdPyKs+aOnqtng7pQ@mail.gmail.com>
 <4F452616.30806@samsung.com>
Message-ID: <CABb+yY2FUj_iqYYWSN8UmXEqUrR0=E05O6EDtBABh4RiF4Qhhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 10:59 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>>>
>>> * Copyright (c) 2012 Samsung Electronics Co., Ltd.
>>> * ? ? ? ? ? ? ? http://www.samsung.com
>>> *
>>> * Copyright (C) 2010 Samsung Electronics Co. Ltd.
>>> * ? ? ? Jaswinder Singh<jassi.brar@samsung.com>
>>> *
>>
>> The following is more appropriate
>>
>> - ?* Copyright (C) 2010 Samsung Electronics Co. Ltd.
>> + * Copyright (C) 2010 - 2012 Samsung Electronics Co. Ltd.
>> ? ?* ? ? ? Jaswinder Singh<jassi.brar@samsung.com>
>>
> Well, as I know, I don't have to change/update original your copyright. If
> required, you should do it, next time.
>
FYI that that is not my copyright. That is Samsung's copyright.
     Jaswinder Singh<jassi.brar@samsung.com>   only claims to be the author.

And I don't expect you to correct my email id (we have to suffer an extra
mundane patch)

>
> I think you can agree following. Let's finish this talking.
>
>
> * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> * ? ? ? ? ? ? ? http://www.samsung.com
> *
> and 'original copyright'...
>
Doesn't make sense. Go look at other files in the kernel to find
how it's done (if you must update the year).

By your logic, next year someone would add
    + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
    + *               http://www.samsung.com

and another year later
    + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
    + *               http://www.samsung.com

and so on....

As I said, simply updating the current year in the same line works.
 -  * Copyright (C) 2010 Samsung Electronics Co. Ltd.
 + * Copyright (C) 2010 - 2012 Samsung Electronics Co. Ltd.
    *       Jaswinder Singh<jassi.brar@samsung.com>
And don't worry, you won't be doing me any favor by doing that.
