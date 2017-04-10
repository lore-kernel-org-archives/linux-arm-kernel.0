From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Apr 2017 09:31:33 +0100
Subject: [PATCH v3 8/9] arm,arm64,drivers: move externs in a new header
 file
In-Reply-To: <20170327131825.32134-9-juri.lelli@arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170327131825.32134-9-juri.lelli@arm.com>
Message-ID: <20170410083133.GD27538@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 02:18:24PM +0100, Juri Lelli wrote:
> Create a new header file (include/linux/arch_topology.h) and put there
> declarations of interfaces used by arm, arm64 and drivers code.
> 
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm/kernel/topology.c    |  7 +------
>  arch/arm64/kernel/topology.c  |  4 +---
>  drivers/base/arch_topology.c  |  1 +
>  include/linux/arch_topology.h | 17 +++++++++++++++++
>  4 files changed, 20 insertions(+), 9 deletions(-)
>  create mode 100644 include/linux/arch_topology.h

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
