From: robh@kernel.org (Rob Herring)
Date: Tue, 20 Sep 2016 09:46:45 -0500
Subject: [PATCH v7 05/22] Docs: dt: document ARM SMMUv3 generic binding
 usage
In-Reply-To: <2273645f1fa5c76b6b98b5fd03804ab8b55a7691.1473695704.git.robin.murphy@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
 <2273645f1fa5c76b6b98b5fd03804ab8b55a7691.1473695704.git.robin.murphy@arm.com>
Message-ID: <20160920144645.GA27580@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 05:13:43PM +0100, Robin Murphy wrote:
> We're about to ratify our use of the generic binding, so document it.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> - Reference PCI "iommu-map" binding instead, as that's our main concern
> - Fix "IDs" typo
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
