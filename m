From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 13 Nov 2017 08:01:43 -0600
Subject: [PATCH] dmaengine: dmatest: move callback wait queue to thread
 context
In-Reply-To: <ed768b4f-7bcb-24a2-5fee-82f9f5954122@codeaurora.org>
References: <1510335864-25997-1-git-send-email-awallis@codeaurora.org>
 <ed768b4f-7bcb-24a2-5fee-82f9f5954122@codeaurora.org>
Message-ID: <197cfdcf-a7c3-51c4-21bb-4b9ba7f771a2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/17 6:52 AM, Adam Wallis wrote:
> Hmm, I think I would need to submit a v2 of this patch removing the
> stable at vger.kernel.org  since this is dependent on my WARN patch in dma
> linux-next tree...however, I don't know what the SHA of that patch will be until
> it's in Linus' tree.
> 
> Any thoughts on that Vinod?

You can specify prerequisite patches in patches for the stable tree.

https://www.kernel.org/doc/html/v4.13/process/stable-kernel-rules.html

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
