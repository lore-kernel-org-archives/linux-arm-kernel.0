From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 May 2013 12:14:59 +0100
Subject: [PATCH 04/11] x86: mm: Remove general hugetlb code from x86.
In-Reply-To: <1369328878-11706-5-git-send-email-steve.capper@linaro.org>
References: <1369328878-11706-1-git-send-email-steve.capper@linaro.org>
 <1369328878-11706-5-git-send-email-steve.capper@linaro.org>
Message-ID: <20130524111459.GG18272@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 06:07:51PM +0100, Steve Capper wrote:
> huge_pte_alloc, huge_pte_offset and follow_huge_p[mu]d have
> already been copied over to mm.
> 
> This patch removes the x86 copies of these functions and activates
> the general ones by enabling:
> CONFIG_ARCH_WANT_GENERAL_HUGETLB
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
