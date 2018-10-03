From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Oct 2018 16:09:10 +0100
Subject: [PATCH v5 04/27] arm64: daifflags: Use irqflags functions for
 daifflags
In-Reply-To: <1535471497-38854-5-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-5-git-send-email-julien.thierry@arm.com>
Message-ID: <20181003150909.GD12998@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 04:51:14PM +0100, Julien Thierry wrote:
> Some of the work done in daifflags save/restore is already provided
> by irqflags functions. Daifflags should always be a superset of irqflags
> (it handles irq status + status of other flags). Modifying behaviour of
> irqflags should alter the behaviour of daifflags.
> 
> Use irqflags_save/restore functions for the corresponding daifflags
> operation.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: James Morse <james.morse@arm.com>

Queued for 4.20. Thanks.

-- 
Catalin
