From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 May 2018 15:01:59 +0200
Subject: [PATCH 10/14] vgem: separate errno from VM_FAULT_* values
In-Reply-To: <20180516095303.GH3438@phenom.ffwll.local>
References: <20180516054348.15950-1-hch@lst.de>
 <20180516054348.15950-11-hch@lst.de>
 <20180516095303.GH3438@phenom.ffwll.local>
Message-ID: <20180516130159.GA32454@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 11:53:03AM +0200, Daniel Vetter wrote:
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Want me to merge this through drm-misc or plan to pick it up yourself?

For now I just want a honest discussion if people really actually
want the vm_fault_t change with the whole picture in place.
