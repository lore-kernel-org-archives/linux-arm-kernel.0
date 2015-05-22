From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 22 May 2015 11:35:05 -0700
Subject: [PATCH v7 6/7] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <CAAS=xmgHJVThR2hVeMYZjKgJdodEG_hrs09BBA01gOXMSc8Rdg@mail.gmail.com>
References: <1432117752-7074-1-git-send-email-bintian.wang@huawei.com>	<1432117752-7074-2-git-send-email-bintian.wang@huawei.com>	<555D09F3.7020506@codeaurora.org>	<555D57BB.8080702@huawei.com>	<555E1D55.1050907@codeaurora.org>	<555EBCA4.9030303@huawei.com>
 <CAAS=xmgHJVThR2hVeMYZjKgJdodEG_hrs09BBA01gOXMSc8Rdg@mail.gmail.com>
Message-ID: <555F76D9.10308@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/15 11:30, Brent Wang wrote:
> Hello Stephen,
>
> 2015-05-22 13:20 GMT+08:00 Bintian <bintian.wang@huawei.com>:
>>
>>>
>>> Is pl011 the uart device? Does it have a node in DT somewhere? If it
>>> does, then we could put the assigned-parents properties in that node so
>>> that when the pl011 probes the uart1 clock has its parent set to
>>> clk_150m. See the "Assigned clock parents and rates" section of
>>> Documentation/devicetree/bindings/clock/clock-bindings.txt.
>>>
>> I will verify this.
> Currently the "assigned-clock*" doesn't work for pl011 UART device
> node, maybe we will
> do some fix for its driver later or other modules.

Why doesn't it work?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
