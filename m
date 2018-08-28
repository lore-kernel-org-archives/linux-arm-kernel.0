From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon, 27 Aug 2018 17:55:21 -0700
Subject: [PATCH] clk: keystone: Enable TISCI clocks if K3_ARCH
In-Reply-To: <20180828005056.27326-1-nm@ti.com>
References: <20180828005056.27326-1-nm@ti.com>
Message-ID: <d2027284-5265-388e-f793-cd048ac8a587@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/27/2018 5:50 PM, Nishanth Menon wrote:
> K3_ARCH uses TISCI for clocks as well. Enable the same
> for the driver support.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Ref: https://patchwork.kernel.org/patch/10447677/
> 
> Since ARCH_K3 only got integrated in v4.19-rc1, rebased to v4.19-rc1 tag..
> 
>   drivers/clk/Makefile         | 1 +
>   drivers/clk/keystone/Kconfig | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
