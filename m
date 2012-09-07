From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 19:11:47 +0000
Subject: [PATCH v3 06/31] arm64: MMU fault handling and page table
 management
In-Reply-To: <1347035226-18649-7-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-7-git-send-email-catalin.marinas@arm.com>
Message-ID: <201209071911.48183.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Catalin Marinas wrote:
> 
> This patch adds support for the handling of the MMU faults (exception
> entry code introduced by a previous patch) and page table management.
> 
> The user translation table is pointed to by TTBR0 and the kernel one
> (swapper_pg_dir) by TTBR1. There is no translation information shared or
> address space overlapping between user and kernel page tables.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
