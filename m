From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 11:51:38 +0000
Subject: [PATCH 4/6] iommu/arm-smmu: provide option to dsb macro when
 publishing tables
In-Reply-To: <1391686253-13436-4-git-send-email-will.deacon@arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
 <1391686253-13436-4-git-send-email-will.deacon@arm.com>
Message-ID: <20140206115137.GM29446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 11:30:51AM +0000, Will Deacon wrote:
> On coherent systems, publishing new page tables to the SMMU walker is
> achieved with a dsb instruction. In fact, this can be a dsb(ishst) which
> also provides the mandatory barrier option for arm64.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
