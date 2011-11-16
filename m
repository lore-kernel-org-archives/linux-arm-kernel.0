From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Nov 2011 23:59:41 +0000
Subject: [PATCH] ARM: Use PMD_SHIFT instead of PGDIR_SHIFT in
 dma-consistent.c
In-Reply-To: <1321461495-2860-1-git-send-email-catalin.marinas@arm.com>
References: <1321461495-2860-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20111116235941.GI9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 04:38:15PM +0000, Catalin Marinas wrote:
> Commit 99d1717d introduces dynamic allocation of the consistent_pte

Always include the commit summary when quoting the commit ID.  Shortened
commit IDs aren't guaranteed to remain unique for any amount of time, and
so become ambiguous (and actually more difficult to locate when that
happens.)
