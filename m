From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 19:52:45 +0000
Subject: [PATCH v3 27/31] arm64: Loadable modules
In-Reply-To: <1347035226-18649-28-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-28-git-send-email-catalin.marinas@arm.com>
Message-ID: <201209071952.45895.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Catalin Marinas wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> This patch adds support for loadable modules. Loadable modules are
> loaded 64MB below the kernel image due to branch relocation restrictions
> (see Documentation/arm64/memory.txt).
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
