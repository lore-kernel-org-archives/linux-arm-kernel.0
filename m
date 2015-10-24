From: jun.nie@linaro.org (Jun Nie)
Date: Sat, 24 Oct 2015 11:23:04 +0800
Subject: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
In-Reply-To: <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
 <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
Message-ID: <CABymUCORU9CDD64Rdw2VX0kLSe6E1zY9iZCap5xittoVFwbOtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-24 5:54 GMT+08:00 Timur Tabi <timur@codeaurora.org>:
> On Sat, Sep 19, 2015 at 1:54 AM, Jun Nie <jun.nie@linaro.org> wrote:
>>
>> I am not sure the silicon designer's plan on the UART IP. Different
>> silicon team have different decision on the IP choice. So I guess
>> future ZTE SOC may reuse ZTE UART per people assignment.
>
> I would rather see this as a separate driver.  I think this patch
> pollutes the amba-pl011.c driver too much.

I am OK to add a new driver for ZTE UART if no other's objection
though I do not agree you. Without this last patch, other patches are
just for minor refactor for register access.

Comment from any other is welcome.

Jun

>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
