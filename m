From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Feb 2011 09:56:17 +0000
Subject: [PATCH v4 02/19] ARM: LPAE: Fix early_pte_alloc() assumption
	about the Linux PTE
In-Reply-To: <1295891761-18366-3-git-send-email-catalin.marinas@arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <20110212095617.GA15616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 05:55:44PM +0000, Catalin Marinas wrote:
> With LPAE we no longer have software bits in a separate Linux PTE and
> the early_pte_alloc() function should pass PTE_HWTABLE_OFF +
> PTE_HWTABLE_SIZE to early_alloc() to avoid allocating extra memory.

This one can also go to the patch system too.
