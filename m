From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 26 Apr 2018 14:09:41 +0200
Subject: [PATCH v2 1/5] drm/nouveau: tegra: Detach from ARM DMA/IOMMU
 mapping
In-Reply-To: <20180425151815.GB16075@infradead.org>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425151815.GB16075@infradead.org>
Message-ID: <20180426120941.GC11985@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 08:18:15AM -0700, Christoph Hellwig wrote:
> The series seems to miss a cover letter.
> 
> Also I really think this patch original patch shouldn't be in the proper
> series.

I added a note explaining why I included this. Not everyone in this
discussion had seen the patch and therefore may not be aware of the
problem that the series attempts to fix. I agree that it shouldn't
be merged as part of the series, though.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/a91efdbf/attachment.sig>
