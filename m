From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Jun 2016 15:30:34 +0100
Subject: [PATCH] arm64:swiotlb:Enable only when Input size through
 command line
In-Reply-To: <1466684020-5224-1-git-send-email-manjeet.p@samsung.com>
References: <1466684020-5224-1-git-send-email-manjeet.p@samsung.com>
Message-ID: <20160623143034.GN6521@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2016 at 05:43:40PM +0530, Manjeet Pawar wrote:
> From: Rohit Thapliyal <r.thapliyal@samsung.com>
> 
> swiotlb default size of 64M is too big as
> default value therefore it is made configurable
> through command line through swiotlb_size parameter.
> swiotlb allocation shall be done only when the
> swiotlb size is given through command line.
> Otherwise no swiotlb is allocated.

I already queued this patch:

http://lkml.kernel.org/g/1465372426-4077-1-git-send-email-jszhang at marvell.com

If you have any objections to it, please reply there.

-- 
Catalin
