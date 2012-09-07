From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 19:46:43 +0000
Subject: [PATCH v3 20/31] arm64: User access library functions
In-Reply-To: <1347035226-18649-21-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-21-git-send-email-catalin.marinas@arm.com>
Message-ID: <201209071946.44184.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Catalin Marinas wrote:
> This patch add support for various user access functions. These
> functions use the standard LDR/STR instructions and not the LDRT/STRT
> variants in order to allow kernel addresses (after set_fs(KERNEL_DS)).
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
