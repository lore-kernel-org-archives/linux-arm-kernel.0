From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Oct 2018 17:20:26 +0100
Subject: [PATCH] arm64: mm: Use #ifdef for the __PAGETABLE_P?D_FOLDED
 defines
In-Reply-To: <20181005134916.12937-1-james.morse@arm.com>
References: <20181005134916.12937-1-james.morse@arm.com>
Message-ID: <20181005162025.k66s44z5ljc6ghsu@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 02:49:16PM +0100, James Morse wrote:
> __is_defined(__PAGETABLE_P?D_FOLDED) doesn't quite work as intended
> as these symbols are internal to asm-generic and aren't defined in the
> way kconfig expects. This makes them always evaluate to false.
> Switch to #ifdef.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> CC: Mark Rutland <mark.rutland@arm.com>

Applied. Thanks.

-- 
Catalin
