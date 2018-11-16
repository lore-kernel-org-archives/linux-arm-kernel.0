From: frowand.list@gmail.com (Frank Rowand)
Date: Thu, 15 Nov 2018 16:16:29 -0800
Subject: [PATCH 0/4 v1] Mezzanine Low Speed connector bus
In-Reply-To: <CACRpkdZsJZDFeera-H2dAV_BJP=94L3gmezmLjDb6hSDubZ_Og@mail.gmail.com>
References: <20180823103332.32047-1-linus.walleij@linaro.org>
 <cd3100ee-03a0-9218-b166-14f15d7669f6@gmail.com>
 <1eaeec41-782d-63fa-b555-f7580ec8812f@gmail.com>
 <CACRpkdZsJZDFeera-H2dAV_BJP=94L3gmezmLjDb6hSDubZ_Og@mail.gmail.com>
Message-ID: <93d1f00a-2a86-bed0-6bbf-a6f86550b59a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/18 2:59 PM, Linus Walleij wrote:
> On Thu, Nov 15, 2018 at 5:27 PM Frank Rowand <frowand.list@gmail.com> wrote:
>> On 8/23/18 4:06 PM, Frank Rowand wrote:
>>> On 08/23/18 03:33, Linus Walleij wrote:
>>>> I have been a bit hesitant to reiterate the series, but this is
>>>> anyways a v1 of the 96Boards Mezzanine Low Speed connector
>>>> driver framework.
>>
>> < snip >
>>
>>> I will read through the rest of the series and revisit my
>>> previous conclusions, but most likely not for a few days.
>>>
>>> -Frank
>>
>> < snip >
>>
>> My apologies for continuing to not getting to this task.  It
>> has been in the top grouping of my todo list but has been
>> pushed aside by a rather busy schedule of conferences and
>> company internal work.  It remains up at the top of my todo
>> list, but most likely will still be shunted aside for three
>> more weeks of other pressing work.
>>
>> I will get to it, I definitely have not forgotten it.
> 
> It's OK, I might get to rebasing the series even.
> 
> We discussed it in a session with Linaro in Vancouver
> recently (some month ago). What we took away from it

It would be helpful for me to look at that.  What was the
title of the session, or a pointer to the resource page
for it?

-Frank

> is that there are many precedents of populating devices
> ad hoc, what really makes this one special is that it takes
> something device tree and ad hoc populates something
> on top of it, not defined in the device tree itself.
> 
> On a related note, Heikki Krogerus is making a software
> FWnode population series. I ran into this when converting
> board files to use more abstract descriptions. Check it out:
> https://marc.info/?l=linux-kernel&m=154177331200561&w=2
> 
> The idea with the series is to expand FWnode so that it
> doesn't only populate Linux devices from device tree
> or ACPI but also by software, where needed, further
> expanding the fwnode abstraction. I will probably look
> into using that.
> 
> Yours,
> Linus Walleij
> 
