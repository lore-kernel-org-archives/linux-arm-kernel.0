From: smuckle@codeaurora.org (Steve Muckle)
Date: Fri, 25 Mar 2011 16:55:16 -0700
Subject: IO access and *_relaxed macros
In-Reply-To: <1301047705.25814.4.camel@e102109-lin.cambridge.arm.com>
References: <4D8B8BD3.5070403@codeaurora.org>
	<1301047705.25814.4.camel@e102109-lin.cambridge.arm.com>
Message-ID: <4D8D2B64.9030709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/11 03:08, Catalin Marinas wrote:
> Are there other scenarios (in relation with coherent DMA buffers) where
> we need a DSB after writel() or before readl()?

I'm not sure about use with DMA buffers - I've just been looking at
these macros with respect to (non-DMA related) device accesses, since
they're heavily used for this purpose as well.

thanks,
Steve

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
