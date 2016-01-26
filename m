From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 26 Jan 2016 16:16:57 +0300
Subject: [PATCH] clk: rockchip: Reparent hclk_rom,
 hclk_i2s0 and hclk_spdif to hclk_cpubus on RK3066/RK3188
In-Reply-To: <18195479.b78tX8z5U3@diego>
References: <1453812250-11819-1-git-send-email-al.kochet@gmail.com>
 <18195479.b78tX8z5U3@diego>
Message-ID: <0F6CFF20-C3D2-4A4D-83D5-1DE6014BB75D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 26 ???. 2016 ?., ? 16:04, Heiko St?bner <heiko@sntech.de> ???????(?):
> 
> Can you instead try to add hclk_cpubus to the critical clock list please?

Yes, adding hclk_cpubus to rk3188_critical_clocks also fixes problem.
So, I?ll send another patch now.

Thank, you.
