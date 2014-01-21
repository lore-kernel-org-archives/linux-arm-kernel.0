From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 21 Jan 2014 10:28:06 -0500
Subject: [PATCH] ARM: Make pgtbl macro more robust
In-Reply-To: <20140117185029.GC13785@codeaurora.org>
References: <1389015593-31716-1-git-send-email-cov@codeaurora.org>
 <20140117185029.GC13785@codeaurora.org>
Message-ID: <52DE9206.1000402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2014 01:50 PM, Stephen Boyd wrote:
> On 01/06, Christopher Covington wrote:
>> The pgtbl macro couldn't handle the specific
>> (TEXT_OFFSET - PG_DIR_SIZE) value that the combination of
>> MSM platforms and LPAE created:
>>
>> head.S:163: Error: invalid constant (203000) after fixup
>>
>> Regardless of whether this combination of configuration options
>> will work on currently support platforms at run time, make it
>> at least assemble properly.
>>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> 
> Looks good to me.
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> I think you can put it in the patch tracker. Russell?

Added as

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7947/1

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
