From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 26 Jan 2016 21:21:38 +0100
Subject: [PATCH] clk: rockchip: add hclk_cpubus to the list of rk3188
 critical clocks
In-Reply-To: <1453815240-15354-1-git-send-email-al.kochet@gmail.com>
References: <1453815240-15354-1-git-send-email-al.kochet@gmail.com>
Message-ID: <12983946.PGshY20RJE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 26. Januar 2016, 16:34:00 schrieb Alexander Kochetkov:
> hclk_cpubus needs to keep running because it is needed for devices like
> the rom, i2s0 or spdif to be accessible via cpu. Without that all
> accesses to devices (readl/writel) return wrong data. So add it
> to the list of critical clocks.
> 
> Fixes: 78eaf6095cc763c ("clk: rockchip: disable unused clocks")
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>

applied to my clk-branch for 4.6


Thanks
Heiko
