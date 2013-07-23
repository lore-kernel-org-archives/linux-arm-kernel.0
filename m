From: horms@verge.net.au (Simon Horman)
Date: Tue, 23 Jul 2013 10:24:33 +0900
Subject: [PATCH v2 03/04] ARM: shmobile: Add EMEV2 and KZM9D to
 ARCH_SHMOBILE_MULTI
In-Reply-To: <20130717203118.27542.37940.sendpatchset@w520>
References: <20130717203049.27542.78385.sendpatchset@w520>
 <20130717203118.27542.37940.sendpatchset@w520>
Message-ID: <20130723012432.GA16481@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 05:31:18AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Enable build of EMEV2 and KZM9D DT Reference in
> case of ARCH_MULTIPLATFORM and ARCH_SHMOBILE_MULTI.
> 
> IS_ENABLED() is leaves the clock-emev2.c file out
> in case of COMMON_CLK=y.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Changes since V1:
>  - use IS_ENABLED() instead of weak symbol, thanks Arnd!
> 
>  arch/arm/boot/dts/Makefile                     |    1 +
>  arch/arm/mach-shmobile/Kconfig                 |   15 +++++++++++++++
>  arch/arm/mach-shmobile/board-kzm9d-reference.c |    3 ++-
>  arch/arm/mach-shmobile/setup-emev2.c           |    3 ++-
>  4 files changed, 20 insertions(+), 2 deletions(-)

Thanks, I have queued this up for v3.12 in a new multiarch branch
of the renesas tree.
