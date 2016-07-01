From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 Jul 2016 11:53:55 +0100
Subject: [PATCH v2 0/6] arm64: Extend Cortex-A53 errata workaround
In-Reply-To: <20160628170732.523-1-andre.przywara@arm.com>
References: <20160628170732.523-1-andre.przywara@arm.com>
Message-ID: <20160701105355.GA14018@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 06:07:26PM +0100, Andre Przywara wrote:
> Andre Przywara (6):
>   Revert "arm64: alternatives: add enable parameter to conditional asm
>     macros"
>   arm64: fix "dc cvau" cache operation on errata-affected core
>   arm64: include alternative handling in dcache_by_line_op
>   arm64: errata: Calling enable functions for CPU errata too
>   arm64: consolidate signal injection on emulation errors
>   arm64: trap userspace "dc cvau" cache operation on errata-affected
>     core

Patches queued for 4.8. Thanks.

-- 
Catalin
