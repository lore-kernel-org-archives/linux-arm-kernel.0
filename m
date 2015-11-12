From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Nov 2015 15:22:11 +0000
Subject: [PATCH 0/3] arm64: make some functions static
In-Reply-To: <1447329884-1644-1-git-send-email-jszhang@marvell.com>
References: <1447329884-1644-1-git-send-email-jszhang@marvell.com>
Message-ID: <20151112152211.GI5627@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 08:04:41PM +0800, Jisheng Zhang wrote:
> These functions are only called within the its own file, so they could
> be declared static.
> 
> Jisheng Zhang (3):
>   arm64: smp: make of_parse_and_init_cpus static
>   arm64: mmu: make split_pud and fixup_executable static
>   arm64: suspend: make hw_breakpoint_restore static

Patches applied. Thanks.

-- 
Catalin
