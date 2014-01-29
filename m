From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 29 Jan 2014 09:00:13 -0500
Subject: [PATCH v3] ARM: hw_breakpoint: Add ARMv8 support
In-Reply-To: <20140129105722.GD26622@mudshark.cambridge.arm.com>
References: <20140128183851.GK2885@mudshark.cambridge.arm.com>
 <1390935112-28465-1-git-send-email-cov@codeaurora.org>
 <20140129105722.GD26622@mudshark.cambridge.arm.com>
Message-ID: <52E9096D.9070800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 01/29/2014 05:57 AM, Will Deacon wrote:
> Hi Christopher,
> 
> On Tue, Jan 28, 2014 at 06:51:51PM +0000, Christopher Covington wrote:
>> Add the trivial support necessary to get hardware breakpoints
>> working for GDB on ARMv8 simulators running in AArch32 mode.
>>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
>> ---
>>
>>  v3: assume for now that ARMv9 and later will update FSR
> 
> Please can you stick this into the patch system? I don't have any other
> hw_breakpoint changes queued, so I doubt I'll send a pull for 3.15.

Thanks for your review. Sounds good; will do.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
