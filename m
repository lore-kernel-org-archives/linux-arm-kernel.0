From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Mar 2016 16:29:42 -0600
Subject: [PATCH 10/12] Docs: dt: document ARM SMMU generic binding usage
In-Reply-To: <af1ce6d7d69e340ac839c69b475728f7aa50ff23.1456514380.git.robin.murphy@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
 <af1ce6d7d69e340ac839c69b475728f7aa50ff23.1456514380.git.robin.murphy@arm.com>
Message-ID: <20160303222942.GA8943@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 01:46:19PM +0000, Robin Murphy wrote:
> Document how the generic "iommus" binding should be used to describe ARM
> SMMU stream IDs instead of the old "mmu-masters" binding.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 40 ++++++++++++++--------
>  1 file changed, 25 insertions(+), 15 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
