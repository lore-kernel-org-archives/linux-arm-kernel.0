From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 13 Aug 2011 15:34:23 +0100
Subject: [PATCH v7 03/16] ARM: LPAE: Use PMD_(SHIFT|SIZE|MASK) instead
	of PGDIR_*
In-Reply-To: <1312988619-16804-4-git-send-email-catalin.marinas@arm.com>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
	<1312988619-16804-4-git-send-email-catalin.marinas@arm.com>
Message-ID: <20110813143423.GP4775@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 04:03:26PM +0100, Catalin Marinas wrote:
> PGDIR_SHIFT and PMD_SHIFT for the classic 2-level page table format have
> the same value (21). This patch converts the PGDIR_* uses in the kernel
> to the PMD_* equivalent so that LPAE builds can reuse the same code.

Ok.
