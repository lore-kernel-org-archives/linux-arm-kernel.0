From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Mon, 14 Apr 2014 15:21:29 -0700
Subject: [PATCH v2] arm64: enable EDAC on arm64
In-Reply-To: <loom.20140410T150903-818@post.gmane.org>
References: <1385154308-31335-1-git-send-email-robherring2@gmail.com>
 <loom.20140410T150903-818@post.gmane.org>
Message-ID: <534C5F69.8030208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/10/2014 6:10 AM, Tomasz Nowicki wrote:
> Rob Herring <robherring2 <at> gmail.com> writes:
>
>> From: Rob Herring <rob.herring <at> calxeda.com>
>>
>> Implement atomic_scrub and enable EDAC for arm64.
>>
>> Signed-off-by: Rob Herring <rob.herring <at> calxeda.com>
>> Cc: Catalin Marinas <catalin.marinas <at> arm.com>
>> Cc: Will Deacon <will.deacon <at> arm.com>
>> ---
>> v2:
>> - Add loop for exclusive store success
>> - Fix size to be 32-bits at a time. The framework gives no alignment
>>    guarantees.
>>
> Hi Rob,
>
> I am working on memory error for ARM64 and wondering what is your plans
> regarding this patch. It looks essential for my further work.
>
> Regards,
> Tomasz
>
Hi Tomasz, Rob,

I am looking at similar information for A53 and A57 for the L1/L2 single 
and double bit ecc errors.
Is there an upstream/linaro effort for EDAC driver in progress ?

-Rohit
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
