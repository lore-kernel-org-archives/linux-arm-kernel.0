From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 19:09:30 +0000
Subject: [PATCH v3 03/31] arm64: Exception handling
In-Reply-To: <1347035226-18649-4-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-4-git-send-email-catalin.marinas@arm.com>
Message-ID: <201209071909.30852.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Catalin Marinas wrote:
> The patch contains the exception entry code (kernel/entry.S), pt_regs
> structure and related accessors, undefined instruction trapping and
> stack tracing.
> 
> AArch64 Linux kernel (including kernel threads) runs in EL1 mode using
> the SP1 stack. The vectors don't have a fixed address, only alignment
> (2^11) requirements.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
