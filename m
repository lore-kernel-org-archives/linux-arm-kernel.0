From: horms@verge.net.au (Simon Horman)
Date: Tue, 23 Jul 2013 10:24:45 +0900
Subject: [PATCH 02/04] ARM: shmobile: Introduce ARCH_SHMOBILE_MULTI
In-Reply-To: <20130717203109.27542.77708.sendpatchset@w520>
References: <20130717203049.27542.78385.sendpatchset@w520>
 <20130717203109.27542.77708.sendpatchset@w520>
Message-ID: <20130723012444.GD16481@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 05:31:09AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add ARCH_SHMOBILE_MULTI to mach-shmobile that can be used
> to enable ARCH_MULTIPLATFORM on selected SoCs and boards.
> 
> The headers stay under arch/arm/mach-shmobile/include/mach/
> for now, they can and will be migrated independently over time.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/Makefile               |    1 +
>  arch/arm/mach-shmobile/Kconfig  |   21 +++++++++++++++++++++
>  arch/arm/mach-shmobile/Makefile |    2 ++
>  3 files changed, 24 insertions(+)

Thanks, I have queued this up for v3.12 in a new multiarch branch
of the renesas tree.
