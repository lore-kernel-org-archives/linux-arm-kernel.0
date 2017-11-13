From: awallis@codeaurora.org (Adam Wallis)
Date: Mon, 13 Nov 2017 09:32:56 -0500
Subject: [PATCH] dmaengine: dmatest: move callback wait queue to thread
 context
In-Reply-To: <197cfdcf-a7c3-51c4-21bb-4b9ba7f771a2@codeaurora.org>
References: <1510335864-25997-1-git-send-email-awallis@codeaurora.org>
 <ed768b4f-7bcb-24a2-5fee-82f9f5954122@codeaurora.org>
 <197cfdcf-a7c3-51c4-21bb-4b9ba7f771a2@codeaurora.org>
Message-ID: <6dc85bd3-8c1f-c0d1-29f4-218e69e0be0a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2017 9:01 AM, Timur Tabi wrote:
> On 11/13/17 6:52 AM, Adam Wallis wrote:
>> Hmm, I think I would need to submit a v2 of this patch removing the
>> stable at vger.kernel.org? since this is dependent on my WARN patch in dma
>> linux-next tree...however, I don't know what the SHA of that patch will be until
>> it's in Linus' tree.
>>
>> Any thoughts on that Vinod?
> 
> You can specify prerequisite patches in patches for the stable tree.
> 
> https://www.kernel.org/doc/html/v4.13/process/stable-kernel-rules.html
> 
Yep, that's what I was referring to in my email.

The form of

Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle

specifies a dependent SHA, which I don't yet know since Linus hasn't pulled
Vinod's tree. Unless I am missing something?

-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
