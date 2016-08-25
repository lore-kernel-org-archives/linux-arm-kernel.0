From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Aug 2016 15:51:45 +0100
Subject: [PATCH v6 1/3] arm64: Create sections.h
In-Reply-To: <1472059650-591-2-git-send-email-james.morse@arm.com>
References: <1472059650-591-1-git-send-email-james.morse@arm.com>
 <1472059650-591-2-git-send-email-james.morse@arm.com>
Message-ID: <20160825145144.GH20748@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 06:27:28PM +0100, James Morse wrote:
> Each time new section markers are added, kernel/vmlinux.ld.S is updated,
> and new extern char __start_foo[] definitions are scattered through the
> tree.
> 
> Create asm/include/sections.h to collect these definitions (and include
> the existing asm-generic version).
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
