From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Apr 2016 17:11:32 +0100
Subject: [PATCH v7 02/16] arm64: Fold proc-macros.S into assembler.h
In-Reply-To: <1459529620-22150-3-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-3-git-send-email-james.morse@arm.com>
Message-ID: <20160418161132.GF18257@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 05:53:26PM +0100, James Morse wrote:
> From: Geoff Levand <geoff@infradead.org>
> 
> To allow the assembler macros defined in arch/arm64/mm/proc-macros.S to
> be used outside the mm code move the contents of proc-macros.S to
> asm/assembler.h.  Also, delete proc-macros.S, and fix up all references
> to proc-macros.S.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> [rebased, included dcache_by_line_op]
> Signed-off-by: James Morse <james.morse@arm.com>

The patch makes sense:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
