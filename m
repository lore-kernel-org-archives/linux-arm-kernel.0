From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 15 Nov 2010 16:25:05 -0800
Subject: [PATCH 14/14] msm: iommu: Miscellaneous code cleanup
In-Reply-To: <1289619000-13167-15-git-send-email-stepanm@codeaurora.org>
References: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
	<1289619000-13167-15-git-send-email-stepanm@codeaurora.org>
Message-ID: <1289867105.4050.29.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-11-12 at 19:30 -0800, Stepan Moskovchenko wrote:
> Remove some unneeded assignments and messages, restructure
> a failure path in iova_to_phys, and make __flush_iotlb
> return int in preparation for adding IOMMU clock control.
> 

Why restructure the failure path ?

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
