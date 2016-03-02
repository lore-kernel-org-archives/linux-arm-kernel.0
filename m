From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Mar 2016 09:49:09 +0000
Subject: [PATCH] arm64: mm: check at build time that PAGE_OFFSET divides
 the VA space evenly
In-Reply-To: <1456908433-27149-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456908433-27149-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160302094909.GB21103@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 09:47:13AM +0100, Ard Biesheuvel wrote:
> Commit 8439e62a1561 ("arm64: mm: use bit ops rather than arithmetic in
> pa/va translations") changed the boundary check against PAGE_OFFSET from
> an arithmetic comparison to a bit test. This means we now silently assume
> that PAGE_OFFSET is a power of 2 that divides the kernel virtual address
> space into two equal halves. So make that assumption explicit.

Applied. Thanks.

-- 
Catalin
