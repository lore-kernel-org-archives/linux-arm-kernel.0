From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 21 Aug 2014 15:24:35 +0200
Subject: [PATCH v2] dma-mapping: Provide write-combine allocations
In-Reply-To: <53F5CC38.7060902@samsung.com>
References: <1403863018-20033-1-git-send-email-thierry.reding@gmail.com>
 <20140801124057.GA19889@ulmo>
 <20140801151917.GS30282@n2100.arm.linux.org.uk>
 <53F5CC38.7060902@samsung.com>
Message-ID: <20140821132433.GC19293@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 12:38:48PM +0200, Marek Szyprowski wrote:
> Hello,
> 
> On 2014-08-01 17:19, Russell King - ARM Linux wrote:
> >On Fri, Aug 01, 2014 at 02:40:59PM +0200, Thierry Reding wrote:
> >>On Fri, Jun 27, 2014 at 11:56:58AM +0200, Thierry Reding wrote:
> >>>From: Thierry Reding <treding@nvidia.com>
> >>>
> >>>Provide an implementation for dma_{alloc,free,mmap}_writecombine() when
> >>>the architecture supports DMA attributes.
> >>>
> >>>Signed-off-by: Thierry Reding <treding@nvidia.com>
> >>>---
> >>>Changes in v2:
> >>>- Add a generic dma_mmap_writecombine() function
> >>>
> >>>  arch/arm/include/asm/dma-mapping.h       | 16 ----------------
> >>>  include/asm-generic/dma-mapping-common.h |  8 --------
> >>>  include/linux/dma-mapping.h              | 26 ++++++++++++++++++++++++++
> >>>  3 files changed, 26 insertions(+), 24 deletions(-)
> >>Ping?
> >I have no problem with this, but I don't think I can say yes to it; that
> >depends whether other people are happy for this to live in
> >include/linux/dma-mapping.h.
> >
> >I guess consent for this change can only come by no one objecting to it
> >after several postings.
> 
> I will take this patch my dma-mapping-next tree and later send pull request
> to Linus, so it will be handled in a similar way as all other changes to
> generic dma-mapping subsystem done in last 2 years.

Okay, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/03c9969d/attachment.sig>
