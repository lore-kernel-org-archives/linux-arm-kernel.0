From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Dec 2015 16:57:04 +0000
Subject: [RFC PATCH] arm64: Documentation: add list of software
 workarounds for errata
In-Reply-To: <1449505814-30096-1-git-send-email-will.deacon@arm.com>
References: <1449505814-30096-1-git-send-email-will.deacon@arm.com>
Message-ID: <20151207165704.GI7083@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 04:30:14PM +0000, Will Deacon wrote:
> +| Implementor    | Component       | Erratum ID      | Kconfig                 |
> ++----------------+-----------------+-----------------+-------------------------+
> +| ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319    |
> +| ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319    |
> +| ARM            | Cortex-A53      | #824069         | ARM64_ERRATUM_824069    |
> +| ARM            | Cortex-A53      | #819472         | ARM64_ERRATUM_819472    |
> +| ARM            | Cortex-A53      | #845719         | ARM64_ERRATUM_845719    |
> +| ARM            | Cortex-A53      | #843419         | ARM64_ERRATUM_843419    |
> +| ARM            | Cortex-A57      | #832075         | ARM64_ERRATUM_832075    |
> +| ARM            | Cortex-A57      | #852523         | N/A                     |
> +| ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220    |
> +|                |                 |                 |                         |
> +| Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
> +| Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |

BTW, since you describe the categories above, shall we add another
column in this table for ARM Ltd hardware categorisation? Most (all, so
far) of them are B anyway.

Also, it would be nice for ARM licensees to add their own categories
description to this document.

Otherwise the doc looks fine:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
