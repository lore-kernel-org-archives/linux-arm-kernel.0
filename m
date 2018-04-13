From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 12 Apr 2018 22:33:42 -0400
Subject: [PATCH v4 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <1523586646-19630-2-git-send-email-okaya@codeaurora.org>
References: <1523586646-19630-1-git-send-email-okaya@codeaurora.org>
 <1523586646-19630-2-git-send-email-okaya@codeaurora.org>
Message-ID: <d1f91bcc-4523-e8fb-2f16-4a5932460d44@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2018 10:30 PM, Sinan Kaya wrote:
> +	/* prevent prefetching of coherent DMA dma prematurely */	\

I tried to write DMA data but my keyboard is not cooperating. I'll hold onto
posting another version until I hear back from you for wmb().

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
