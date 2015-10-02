From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 2 Oct 2015 16:49:01 +0100
Subject: [PATCH 09/15] arm64: Add page size to the kernel image header
In-Reply-To: <1442331684-28818-10-git-send-email-suzuki.poulose@arm.com>
References: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
 <1442331684-28818-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151002154900.GN6963@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 04:41:18PM +0100, Suzuki K. Poulose wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> This patch adds the page size to the arm64 kernel image header
> so that one can infer the PAGESIZE used by the kernel. This will
> be helpful to diagnose failures to boot the kernel with page size
> not supported by the CPU.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This patch needs you signed-off-by as well since you are posting it. And
IIRC I acked it as well, I'll check.

If you are fine with adding your signed-of-by, I can add it to the patch
when applying (unless I see other issues with the series).

-- 
Catalin
