From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Aug 2011 17:52:58 +0200
Subject: [GIT PULL] at91: fixes for 3.1
In-Reply-To: <4E54CE15.1020504@atmel.com>
References: <4E54CE15.1020504@atmel.com>
Message-ID: <201108261752.58929.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 August 2011, Nicolas Ferre wrote:
> Hi Arnd,
> 
> Can you please pull this "fixes" patch since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:
> 
>   Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)
> 
> It is available in the git repository at:
>   git://github.com/at91linux/linux-2.6-at91.git at91-fixes
> 
> Jean-Christophe PLAGNIOL-VILLARD (1):
>       at91: at91sam9261.c: fix typo in t2_clk alias for atmel_tcb.0
> 
>  arch/arm/mach-at91/at91sam9261.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> It is a single patch but I prefer to send you a 
> pull request as it may integrate better with your
> flow...

Yes that helps. I pulled it into the fixes branch now, thanks!

	Arnd
