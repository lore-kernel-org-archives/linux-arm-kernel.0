From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 21 Mar 2014 17:04:44 +0100
Subject: [PATCH 1/5] clk: berlin: add support for berlin plls
In-Reply-To: <20140321155633.GF6443@piout.net>
References: <1395402220-23503-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395402220-23503-2-git-send-email-alexandre.belloni@free-electrons.com>
 <532C355C.3090606@gmail.com> <20140321155633.GF6443@piout.net>
Message-ID: <532C631C.5070105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2014 04:56 PM, Alexandre Belloni wrote:
> On 21/03/2014 at 13:49:32 +0100, Sebastian Hesselbarth wrote :
>> On 03/21/2014 12:43 PM, Alexandre Belloni wrote:
>>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>>> index a367a9831717..4a2602737c27 100644
>>> --- a/drivers/clk/Makefile
>>> +++ b/drivers/clk/Makefile
>>> @@ -29,6 +29,7 @@ obj-$(CONFIG_ARCH_VT8500)		+= clk-vt8500.o
>>>   obj-$(CONFIG_COMMON_CLK_WM831X)		+= clk-wm831x.o
>>>   obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
>>>   obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
>>> +obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
>>>   obj-$(CONFIG_ARCH_HI3xxx)		+= hisilicon/
>>>   obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
>>
>> I'll have a look at clk/Makefile later myself, but alphabetic ordering
>> seems to be broken by ARCH_HI3xxx already. Anyway, we shouldn't just
>> add another violator.
>>
>
> BTW,  don't think there is any issue here, the Makefile states:
> # please keep this section sorted lexicographically by file/directory path name

Ok, thanks for the clarification. As I said, I should have
looked it up myself in the first place.

Sebastian
