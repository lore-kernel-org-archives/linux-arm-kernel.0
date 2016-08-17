From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 16 Aug 2016 23:00:36 -0400
Subject: [PATCH 17/34] clk: maxgen: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <CAJOFmgzfvUza7DQeMsd0bD_e=+P5=WGT8kOkV7H5CCwVq4Z0RQ@mail.gmail.com>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-18-stephen.boyd@linaro.org>
 <CABxcv=mWdwPrGRrP7ay=2FBxzoew6yBdfjZNvgFeDGACnQZdcQ@mail.gmail.com>
 <665a9824-b0c5-9eb3-d4b6-4821204d5db0@osg.samsung.com>
 <CAJOFmgzfvUza7DQeMsd0bD_e=+P5=WGT8kOkV7H5CCwVq4Z0RQ@mail.gmail.com>
Message-ID: <4aacc9ef-16ff-07f2-11f7-91b056855725@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

On 08/16/2016 04:06 PM, Stephen Boyd wrote:
> On Tue, Jun 7, 2016 at 11:55 AM, Javier Martinez Canillas
>>>
>>> I tried this patch on top of linux-next and my Peach Pi Chromebook
>>> (that has a max77802 chip) failed to boot. Following is the relevant
>>> parts from the boot log:
>>>
>>
>> It seems the mailer did a mess with the line wrapping so here's another attempt:
>>
> 
> Thanks! Found the problem too.
> 

Great! Thanks a lot for finding the issue.
I tested v2 of your patch and it worked well indeed.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
