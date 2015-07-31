From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 31 Jul 2015 14:11:27 -0700
Subject: [PATCH 23/23] clk: at91: Revert "keep slow clk enabled to prevent
 system hang"
In-Reply-To: <20150731210905.GM27985@piout.net>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1438335599-3301-24-git-send-email-alexandre.belloni@free-electrons.com>
 <55BBC5CC.80406@codeaurora.org> <20150731210905.GM27985@piout.net>
Message-ID: <55BBE47F.3010307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2015 02:09 PM, Alexandre Belloni wrote:
> On 31/07/2015 at 12:00:28 -0700, Stephen Boyd wrote :
>> On 07/31/2015 02:39 AM, Alexandre Belloni wrote:
>>> -	clk_prepare_enable(slow_clk);
>>> -
>>> -	return 0;
>>> -}
>>> -arch_initcall(of_at91_clk_slow_retain);
>> Can you drop the include of clk.h in this file too?
>>
> Sure! I will do that in v3. However, I'll wait for some feedback from
> the other maintainers before sending again.
>

Cool. Also, are you going to take this through arm-soc? If so, feel free 
to add my ack.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
