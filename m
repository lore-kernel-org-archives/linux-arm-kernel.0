From: jun.nie@linaro.org (Jun Nie)
Date: Mon, 26 Oct 2015 09:27:44 +0800
Subject: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
In-Reply-To: <562AFBD5.3050508@codeaurora.org>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
 <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
 <CABymUCORU9CDD64Rdw2VX0kLSe6E1zY9iZCap5xittoVFwbOtw@mail.gmail.com>
 <562AFBD5.3050508@codeaurora.org>
Message-ID: <CABymUCMAc59SCBnji8bcHkYzuFMbA3GMZL0Cv6ReuK=27kBW4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-24 11:32 GMT+08:00 Timur Tabi <timur@codeaurora.org>:
> Jun Nie wrote:
>>
>> I am OK to add a new driver for ZTE UART if no other's objection
>> though I do not agree you. Without this last patch, other patches are
>> just for minor refactor for register access.
>
>
> In that case, my vote is to drop the whole patchset.  Just copy/paste the
> amba-pl011 driver and make whatever changes you need.  That sort of thing
> happens all the time.

Greg, Peter & Russel,

What's your opinion on this separate UART driver suggestion?

Jun

>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, hosted by The Linux Foundation.
