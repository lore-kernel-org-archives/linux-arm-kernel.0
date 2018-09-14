From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 14 Sep 2018 18:11:56 +0200
Subject: [RFC PATCH 1/3] ARM: dma-mapping: update comment about handling
 dma_ops when detaching from IOMMU
In-Reply-To: <CAMuHMdV_xpj62BkqwoTAaaugM3BkDRQTC=E0cEDqKBg3sUYNBg@mail.gmail.com>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
 <20180913151716.6333-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdV_xpj62BkqwoTAaaugM3BkDRQTC=E0cEDqKBg3sUYNBg@mail.gmail.com>
Message-ID: <20180914161156.GB906@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2018 at 02:15:01PM +0200, Geert Uytterhoeven wrote:
> On Thu, Sep 13, 2018 at 5:18 PM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > Update the comment because we don't set the pointer to NULL anymore.
> > Also use the correct pointer name 'dma_ops' instead of 'dma_map_ops'.
> >
> > Fixes: 1874619a7df4 ("ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()")
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Nice catch!
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, so I sent this seperately via ALKML now.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180914/5324eb38/attachment.sig>
