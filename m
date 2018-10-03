From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Oct 2018 16:14:42 +0100
Subject: [PATCH v5 07/27] arm64: xen: Use existing helper to check
 interrupt status
In-Reply-To: <1535471497-38854-8-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-8-git-send-email-julien.thierry@arm.com>
Message-ID: <20181003151441.GF12998@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 04:51:17PM +0100, Julien Thierry wrote:
> The status of interrupts might depend on more than just pstate. Use
> interrupts_disabled() instead of raw_irqs_disabled_flags() to take the full
> context into account.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Queued for 4.20. Thanks.

-- 
Catalin
