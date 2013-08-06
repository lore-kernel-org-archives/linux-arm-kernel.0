From: horms@verge.net.au (Simon Horman)
Date: Tue, 6 Aug 2013 15:23:27 +0900
Subject: [GIT PULL 0/4] Renesas ARM based SoC multiplatform updates for
 v3.12
In-Reply-To: <cover.1375161473.git.horms+renesas@verge.net.au>
References: <cover.1375161473.git.horms+renesas@verge.net.au>
Message-ID: <20130806062327.GF18246@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Correct subject prefix to "GIT PULL" ]

On Tue, Jul 30, 2013 at 02:24:00PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following Renesas ARM based SoC multiplatform updates
> for v3.12. This pull-request is based on renesas-dt-for-v3.12, which I have
> already sent a pull-request for, in order to provide pre-requisite code.
> 
> The following changes since commit 66a5cab04d339d02b93a4671eadf8e251dbfdc2c:
> 
>   ARM: shmobile: Add SMSC ethernet chip to KZM9D DT reference (2013-07-17 10:06:47 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-multiplatform-for-v3.12
> 
> for you to fetch changes up to fd071b669ee2405e986636e389a3d1b6776e50a0:
> 
>   ARM: shmobile: Allow ARCH_SHMOBILE_MULTI timer configuration (2013-07-23 09:52:44 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM based SoC multiplatform updates for v3.12
> 
> Move Renesas ARM based SoCs a little closer to using
> multiplatform by adding ARCH_SHMOBILE_MULTI and only
> building clocks when COMMON_CLK=n.
> 
> ----------------------------------------------------------------
> Magnus Damm (4):
>       ARM: shmobile: Only build clocks when COMMON_CLK=n
>       ARM: shmobile: Introduce ARCH_SHMOBILE_MULTI
>       ARM: shmobile: Add EMEV2 and KZM9D to ARCH_SHMOBILE_MULTI
>       ARM: shmobile: Allow ARCH_SHMOBILE_MULTI timer configuration
> 
>  arch/arm/Makefile                              |  1 +
>  arch/arm/boot/dts/Makefile                     |  1 +
>  arch/arm/mach-shmobile/Kconfig                 | 52 +++++++++++++++++++++++---
>  arch/arm/mach-shmobile/Makefile                | 33 +++++++++++-----
>  arch/arm/mach-shmobile/board-kzm9d-reference.c |  3 +-
>  arch/arm/mach-shmobile/setup-emev2.c           |  3 +-
>  6 files changed, 77 insertions(+), 16 deletions(-)
> 
