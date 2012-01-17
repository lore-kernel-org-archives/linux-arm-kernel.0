From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 17 Jan 2012 19:15:02 +0530
Subject: [PATCH v2 0/2] Add Qualcomm MSM ADM DMAEngine driver
In-Reply-To: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org>
References: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org>
Message-ID: <1326807902.1540.116.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-01-06 at 18:17 +0530, Ravi Kumar V wrote:
<sorry for delayed review, was on vacation and now traveling >
> 
> As our ADM Scatter-gather hardware needs
> -32-bit command configuration parameter
>  apart from 
> -32-bit source address
> -32-bit destination address
> -16-bit length
> 
> So,we have added new parameter in struct scatterlist to support xfer
> descriptor
> specific private data, and for supporting ADM Box mode DMA we added
> new
> API and data structure. 
what do you mean by "ADM Box mode"?

-- 
~Vinod
