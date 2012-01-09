From: rob@ti.com (Rob Clark)
Date: Mon, 9 Jan 2012 09:17:05 -0600
Subject: [RFC v2 1/2] dma-buf: Introduce dma buffer sharing mechanism
In-Reply-To: <CAAQKjZMEsuib18RYE7OvZPUqhKnvrZ8i3+EMuZSXr9KPVygo_Q@mail.gmail.com>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <1322816252-19955-2-git-send-email-sumit.semwal@ti.com>
 <CAAQKjZPFh6666JKc-XJfKYePQ_F0MNF6FkY=zKypWb52VVX3YQ@mail.gmail.com>
 <20120109081030.GA3723@phenom.ffwll.local>
 <CAAQKjZMEsuib18RYE7OvZPUqhKnvrZ8i3+EMuZSXr9KPVygo_Q@mail.gmail.com>
Message-ID: <CAF6AEGsTGOxyTX6Xijvm8UXGjtVTtYg5X5xfJo8D+47o+xU+bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 9, 2012 at 4:10 AM, InKi Dae <daeinki@gmail.com> wrote:
> note : in case of sharing a buffer between v4l2 and drm driver, the
> memory info would be copied vb2_xx_buf to xx_gem or xx_gem to
> vb2_xx_buf through sg table. in this case, only memory info is used to
> share, not some objects.

which v4l2/vb2 patches are you looking at?  The patches I was using,
vb2 holds a reference to the 'struct dma_buf *' internally, not just
keeping the sg_table

BR,
-R
