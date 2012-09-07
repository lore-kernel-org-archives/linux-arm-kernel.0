From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 19:28:52 +0000
Subject: [PATCH v3 10/31] arm64: TLB maintenance functionality
In-Reply-To: <1347035226-18649-11-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-11-git-send-email-catalin.marinas@arm.com>
Message-ID: <201209071928.52417.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Catalin Marinas wrote:
> 
> This patch adds the TLB maintenance functions. There is no distinction
> made between the I and D TLBs. TLB maintenance operations are
> automatically broadcast between CPUs in hardware. The inner-shareable
> operations are always present, even on UP systems.
> 
> NOTE: Large part of this patch to be dropped once Peter Z's generic
> mmu_gather patches are merged.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
