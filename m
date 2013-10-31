From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Oct 2013 00:48:44 +0000
Subject: [PATCH 3/6] iommu/arm-smmu: Support buggy implementations where
 all config accesses are secure
In-Reply-To: <1382127195-15261-4-git-send-email-andreas.herrmann@calxeda.com>
References: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
 <1382127195-15261-4-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20131031004844.GC28613@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 09:13:12PM +0100, Andreas Herrmann wrote:
> In such a case we have to use secure aliases of some non-secure
> registers.
> 
> This handling is switched on by DT property
> "arm,smmu-secure-config-access" for an SMMU node.

This looks fine, but won't apply without the device isolation changes.

Will
