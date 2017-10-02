From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 2 Oct 2017 15:48:07 +0200
Subject: [PATCH v2 1/2] iommu/io-pgtable-arm: Convert to IOMMU API TLB sync
In-Reply-To: <1eaf255a7a334b3b1b100da8b75b73d19c924860.1506610256.git.robin.murphy@arm.com>
References: <1eaf255a7a334b3b1b100da8b75b73d19c924860.1506610256.git.robin.murphy@arm.com>
Message-ID: <20171002134807.GX8398@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 03:55:01PM +0100, Robin Murphy wrote:
> Now that the core API issues its own post-unmap TLB sync call, push that
> operation out from the io-pgtable-arm internals into the users. For now,
> we leave the invalidation implicit in the unmap operation, since none of
> the current users would benefit much from any change to that.
> 
> CC: Magnus Damm <damm+renesas@opensource.se>
> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>


Applied both, thanks.
