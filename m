From: joro@8bytes.org (joro at 8bytes.org)
Date: Wed, 1 Apr 2015 23:28:54 +0200
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150401163618.GN1552@arm.com>
References: <20150327171946.GL1562@arm.com>
 <1427894051.22236.6.camel@infradead.org>
 <20150401133908.GI1552@arm.com>
 <1427896377.22236.8.camel@infradead.org>
 <20150401140512.GJ1552@arm.com>
 <1427898490.22236.10.camel@infradead.org>
 <20150401143904.GL1552@arm.com>
 <1427899570.22236.14.camel@infradead.org>
 <20150401163618.GN1552@arm.com>
Message-ID: <20150401212854.GK4441@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 05:36:18PM +0100, Will Deacon wrote:
> The issue (speaking in terms of the ARM SMMU, since that's what I'm familiar
> with) is that we don't know the page sizes until we've chosen our
> translation regime.

Can't you hard-code one regime in the driver and just don't use the
others? Or might a SMMU only support a subset of the possible regimes?


	Joerg
