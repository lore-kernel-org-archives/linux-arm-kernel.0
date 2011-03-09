From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 09 Mar 2011 11:36:43 -0800
Subject: [PATCH] ARM: hw_breakpoint: Fix newlines in WARNings
In-Reply-To: <1298693163-18269-1-git-send-email-sboyd@codeaurora.org>
References: <1298633466.32588.1.camel@e102144-lin.cambridge.arm.com>
	<1298693163-18269-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <4D77D6CB.402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On 02/25/2011 08:06 PM, Stephen Boyd wrote:
> Will Deacon wrote:
>>> I'd prefer the message text not to be line wrapped, even if it
>>> violates the general line length rule, because that makes it easier to
>>> grep for the message in the source code.
>> Ok, that's understandable. Moving the text onto its own line will limit
>> the damage to the line length too. Stephen - are you happy to make these
>> changes as part of your previous patch?
>

Do you want to take this? I'm going to submit it to the patch tracker
tomorrow otherwise.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
