From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 06 Apr 2016 16:31:13 -0700
Subject: [PATCH] ARM: dts: rockchip: move rk3036 memory definition to
 board files
In-Reply-To: <1459432238-6469-1-git-send-email-heiko@sntech.de>
References: <1459432238-6469-1-git-send-email-heiko@sntech.de>
Message-ID: <7054534.T1DuSsWYMd@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 31. M?rz 2016, 15:50:38 schrieb Heiko Stuebner:
> The amount of available memory is clearly a board-specific value, so
> the core per-soc dtsi should not define a default of any sort.
> Therefore move the memory-nodes to the two board files.
> 
> Also fix the amount of memory on Kylin (512MB instead of 1GB).
> While in most cases the bootloader will override this with the
> actual amount of memory, there is no need to keep known wrong values
> in the board-dts.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied to my dts32 branch for 4.7
