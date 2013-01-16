From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Wed, 16 Jan 2013 12:51:55 +0000
Subject: ARM DMA: Fix in dma_cache_maint_page
In-Reply-To: <50F6A14C.6040206@codeaurora.org>
References: <50F69F72.4030807@codeaurora.org> <50F6A14C.6040206@codeaurora.org>
Message-ID: <1358340715.2384.23.camel@dabdike.int.hansenpartnership.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-16 at 18:17 +0530, Subhash Jadavani wrote:
> Is it possible to pick up James patch below? Thread here: 
> http://comments.gmane.org/gmane.linux.kernel.mmc/18670, have the details 
> on the motivation behind this fix.

Someone should also audit the arm kernel code for more of these linear
page array assumptions.  I'm guessing that when sparsemem was added to
arm over a year ago, whoever did it either didn't audit or missed a few.

James
