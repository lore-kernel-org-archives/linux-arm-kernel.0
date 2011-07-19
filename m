From: ben@trinity.fluff.org (Ben Dooks)
Date: Tue, 19 Jul 2011 15:51:33 +0100
Subject: [GIT PULL] arm-soc: last minute arm/davinci fixes for 3.0
In-Reply-To: <201107191606.26837.arnd@arndb.de>
References: <201107191606.26837.arnd@arndb.de>
Message-ID: <20110719145133.GA28651@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 04:06:26PM +0200, Arnd Bergmann wrote:
> Hi Linus,
> 
> I got some last bug fixes for 3.0. Please pull if you still take 3.0 related
> changes, otherwise I'll mark them for stable backports and put them into
> the first arm-soc batch for the 3.1 merge window.
> 
> 	Arnd
> 
> The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:
> 
>   Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)
> 
> are available in the git repository at:
>   git+ssh://master.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.git fixes
> 
> Ido Yariv (1):
>       arm: davinci: Fix low level gpio irq handlers' argument
> 
> Jon Povey (1):
>       davinci: DM365 EVM: fix video input mux bits
> 
> Todd Poynor (1):
>       ARM: davinci: Check for NULL return from irq_alloc_generic_chip

any chance we could get a standardisation on the prefix for the
commit messages please?
 
>  arch/arm/mach-davinci/board-dm365-evm.c |    4 ++--
>  arch/arm/mach-davinci/gpio.c            |   21 ++++++++++++++++-----
>  arch/arm/mach-davinci/irq.c             |    6 ++++++
>  3 files changed, 24 insertions(+), 7 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
