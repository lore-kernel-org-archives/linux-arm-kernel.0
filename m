From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 15 Sep 2016 16:11:32 -0700
Subject: [PATCH 0/3] clk: sunxi-ng: sun6i-a31: Register offset and clk
 flag fixes
In-Reply-To: <20160915083436.GC10128@lukather>
References: <20160915065740.13664-1-wens@csie.org>
 <20160915083436.GC10128@lukather>
Message-ID: <daee8cd5-c1a1-49c3-e0f8-e83bb9ed3263@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2016 01:34 AM, Maxime Ripard wrote:
> Hi,
>
> On Thu, Sep 15, 2016 at 02:57:37PM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> Here are 3 fixes for the new sunxi-ng clk driver for sun6i-a31 recently
>> introduced for 4.9. The issues were noticed while working on the display
>> pipeline for the A31/A31s. The second patch follows what Maxime has done
>> for the A33 CCU driver. The third issue was noticed while doing the first
>> patch.
>>
>> I hope we can get this into 4.9 as well, either right in -rc1, or in a
>> later -rc.
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> Stephen, could you apply those patches directly on top of my previous
> PR, or do you want me to send another one?
>

I can apply directly to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
