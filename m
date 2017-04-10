From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Apr 2017 09:32:42 +0100
Subject: [PATCH v3 9/9] arm, arm64, drivers: add a prefix to drivers
 arch_topology interfaces
In-Reply-To: <20170327131825.32134-10-juri.lelli@arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170327131825.32134-10-juri.lelli@arm.com>
Message-ID: <20170410083242.GE27538@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 02:18:25PM +0100, Juri Lelli wrote:
> Now that some functions that deal with arch topology information live
> under drivers, there is a clash of naming that might create confusion.
> 
> Tidy things up by creating a drivers namespace for interfaces used by
> arch code; achieve this by prepending a 'atd_' (arch topology driver)
> prefix to driver interfaces.
> 
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm/kernel/topology.c    |  8 ++++----
>  arch/arm64/kernel/topology.c  |  4 ++--
>  drivers/base/arch_topology.c  | 20 ++++++++++----------
>  include/linux/arch_topology.h |  8 ++++----
>  4 files changed, 20 insertions(+), 20 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
