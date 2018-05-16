From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 16 May 2018 06:13:04 -0700
Subject: [PATCH 10/14] vgem: separate errno from VM_FAULT_* values
In-Reply-To: <20180516130159.GA32454@lst.de>
References: <20180516054348.15950-1-hch@lst.de>
 <20180516054348.15950-11-hch@lst.de>
 <20180516095303.GH3438@phenom.ffwll.local>
 <20180516130159.GA32454@lst.de>
Message-ID: <20180516131304.GF20670@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 03:01:59PM +0200, Christoph Hellwig wrote:
> On Wed, May 16, 2018 at 11:53:03AM +0200, Daniel Vetter wrote:
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > Want me to merge this through drm-misc or plan to pick it up yourself?
> 
> For now I just want a honest discussion if people really actually
> want the vm_fault_t change with the whole picture in place.

That discussion already happened on the -mm mailing list.  And again
at LSFMM.  Both times the answer was yes.
