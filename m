From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 27 Oct 2015 09:31:13 -0400
Subject: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
In-Reply-To: <CABymUCMAc59SCBnji8bcHkYzuFMbA3GMZL0Cv6ReuK=27kBW4Q@mail.gmail.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
 <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
 <CABymUCORU9CDD64Rdw2VX0kLSe6E1zY9iZCap5xittoVFwbOtw@mail.gmail.com>
 <562AFBD5.3050508@codeaurora.org>
 <CABymUCMAc59SCBnji8bcHkYzuFMbA3GMZL0Cv6ReuK=27kBW4Q@mail.gmail.com>
Message-ID: <562F7CA1.5080100@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2015 09:27 PM, Jun Nie wrote:
> 2015-10-24 11:32 GMT+08:00 Timur Tabi <timur@codeaurora.org>:
>> Jun Nie wrote:
>>>
>>> I am OK to add a new driver for ZTE UART if no other's objection
>>> though I do not agree you. Without this last patch, other patches are
>>> just for minor refactor for register access.
>>
>>
>> In that case, my vote is to drop the whole patchset.  Just copy/paste the
>> amba-pl011 driver and make whatever changes you need.  That sort of thing
>> happens all the time.
> 
> Greg, Peter & Russell,
> 
> What's your opinion on this separate UART driver suggestion?

That's crazy; fork the driver simply because the register i/o addresses
are different? No.

On the contrary, this patchset directly triggered important improvements to
both this driver and the ARM arch.

Regards,
Peter Hurley
