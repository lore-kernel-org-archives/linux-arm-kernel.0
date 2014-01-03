From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 03 Jan 2014 11:48:47 -0800
Subject: [PATCHv12 06/49] clk: add support for low level register ops
In-Reply-To: <52C67F53.6000402@ti.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
 <1387557274-22583-6-git-send-email-t-kristo@ti.com>
 <20131222173926.GB8064@book.gsilab.sittig.org> <52C67F53.6000402@ti.com>
Message-ID: <52C7141F.2020901@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/14 01:13, Tero Kristo wrote:
> On 12/22/2013 07:39 PM, Gerhard Sittig wrote:
>>
>>
>> Further I'd suggest to split this register access aspect out of
>> the TI clock series, and to prepare it already for regmap style
>> access to the hardware registers.  See the next comment below.
>
> This sounds like a good idea to me, seeing it is blocking lots of
> other things.

This ll_ops struct looks like a simplified regmap. Have you seen my
series that adds regmap support to the common clock framework[1]? Is
there any reason why you can't use those patches and layer some patches
on top to add support for regmap to the basic clock types?

[1] https://lkml.org/lkml/2013/12/23/461

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
