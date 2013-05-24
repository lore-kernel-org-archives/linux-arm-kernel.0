From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 May 2013 12:13:59 +0100
Subject: [PATCH 02/11] x86: mm: Remove x86 version of huge_pmd_share.
In-Reply-To: <1369328878-11706-3-git-send-email-steve.capper@linaro.org>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-3-git-send-email-steve.capper@linaro.org>
Message-ID: <20130524111359.GE18272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 06:07:49PM +0100, Steve Capper wrote:
> The huge_pmd_share code has been copied over to mm/hugetlb.c to
> make it accessible to other architectures.
> 
> Remove the x86 copy of the huge_pmd_share code and enable the
> ARCH_WANT_HUGE_PMD_SHARE config flag. That way we reference the
> general one.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
