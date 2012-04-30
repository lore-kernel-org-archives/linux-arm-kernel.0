From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Apr 2012 14:21:45 +0000
Subject: [PATCH] ARM: kirkwood: add missing kexec.h include
In-Reply-To: <1335706842-11725-1-git-send-email-ijc@hellion.org.uk>
References: <1335706842-11725-1-git-send-email-ijc@hellion.org.uk>
Message-ID: <201204301421.45446.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 29 April 2012, Ian Campbell wrote:
> 
> Fixes the following build error when CONFIG_KEXEC is enabled:
>   CC      arch/arm/mach-kirkwood/board-dt.o
> arch/arm/mach-kirkwood/board-dt.c: In function 'kirkwood_dt_init':
> arch/arm/mach-kirkwood/board-dt.c:52:2: error: 'kexec_reinit' undeclared (first use in this function)
> arch/arm/mach-kirkwood/board-dt.c:52:2: note: each undeclared identifier is reported only once for each function it appears in
> 
> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> [v4, rebase onto recent Linus for repost]
> [v3, speak actual English in the commit message, thanks Sergei Shtylyov]
> [v2, using linux/kexec.h not asm/kexec.h]

Acked-by: Arnd Bergmann <arnd@arndb.de>

Jason, can you apply this patch on your tree?

	Arnd
