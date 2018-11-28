From: Steve.Capper@arm.com (Steve Capper)
Date: Wed, 28 Nov 2018 16:31:56 +0000
Subject: [PATCH V3 3/5] arm64: mm: Define arch_get_mmap_end,
 arch_get_mmap_base
In-Reply-To: <20181127171017.GD3563@arrakis.emea.arm.com>
References: <20181114133920.7134-1-steve.capper@arm.com>
 <20181114133920.7134-4-steve.capper@arm.com>
 <20181127171017.GD3563@arrakis.emea.arm.com>
Message-ID: <20181128163147.GB20432@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 05:10:18PM +0000, Catalin Marinas wrote:
> On Wed, Nov 14, 2018 at 01:39:18PM +0000, Steve Capper wrote:
> > Now that we have DEFAULT_MAP_WINDOW defined, we can arch_get_mmap_end
> > and arch_get_mmap_base helpers to allow for high addresses in mmap.
> > 
> > Signed-off-by: Steve Capper <steve.capper@arm.com>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!
