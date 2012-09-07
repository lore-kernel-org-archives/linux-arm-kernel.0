From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 19:40:25 +0000
Subject: [PATCH v3 16/31] arm64: ELF definitions
In-Reply-To: <1347035226-18649-17-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-17-git-send-email-catalin.marinas@arm.com>
Message-ID: <201209071940.25377.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Catalin Marinas wrote:
> This patch adds definitions for the ELF format, including personality
> personality setting and EXEC_PAGESIZE. The are only two hwcap
> definitions for 64-bit applications - HWCAP_FP and HWCAP_ASIMD.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
