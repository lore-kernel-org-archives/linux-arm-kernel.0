From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 May 2012 14:20:26 -0400
Subject: [PATCH] ARM: kirkwood: add missing kexec.h include
In-Reply-To: <201204301421.45446.arnd@arndb.de>
References: <1335706842-11725-1-git-send-email-ijc@hellion.org.uk>
 <201204301421.45446.arnd@arndb.de>
Message-ID: <20120508182026.GF15711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 02:21:45PM +0000, Arnd Bergmann wrote:
> On Sunday 29 April 2012, Ian Campbell wrote:
> > 
> > Fixes the following build error when CONFIG_KEXEC is enabled:
> >   CC      arch/arm/mach-kirkwood/board-dt.o
> > arch/arm/mach-kirkwood/board-dt.c: In function 'kirkwood_dt_init':
> > arch/arm/mach-kirkwood/board-dt.c:52:2: error: 'kexec_reinit' undeclared (first use in this function)
> > arch/arm/mach-kirkwood/board-dt.c:52:2: note: each undeclared identifier is reported only once for each function it appears in
> > 
> > Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> > [v4, rebase onto recent Linus for repost]
> > [v3, speak actual English in the commit message, thanks Sergei Shtylyov]
> > [v2, using linux/kexec.h not asm/kexec.h]
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Jason, can you apply this patch on your tree?

Got it, putting together a branch for v3.4 fixes now.

thx,

Jason.
