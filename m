From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 26 Jul 2013 14:40:48 +0100
Subject: [PATCH 1/2] ARM: mm: Remove general hugetlb code from ARM.
In-Reply-To: <20130717154338.GI27948@arm.com>
References: <1374067574-32034-1-git-send-email-steve.capper@linaro.org>
 <1374067574-32034-2-git-send-email-steve.capper@linaro.org>
 <20130717154338.GI27948@arm.com>
Message-ID: <20130726134048.GA4255@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 04:43:38PM +0100, Catalin Marinas wrote:
> On Wed, Jul 17, 2013 at 02:26:13PM +0100, Steve Capper wrote:
> > General forms of huge_pte_alloc, huge_pte_offset and follow_huge_pmd
> > are now available in mm/hugetlb.c.
> > 
> > This patch removes the ARM copies of these functions and activates
> > the general ones by enabling:
> > CONFIG_ARCH_WANT_GENERAL_HUGETLB
> > 
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

If no-one has any objections should I put this into Russell's
patch system?

Cheers,
-- 
Steve
