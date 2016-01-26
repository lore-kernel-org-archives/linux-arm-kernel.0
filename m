From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 26 Jan 2016 10:30:56 -0800
Subject: [PATCH v4 05/13] mmc: sdhci-of-arasan: fix clk issue in
 sdhci_arasan_remove()
In-Reply-To: <1453803353-6266-6-git-send-email-jszhang@marvell.com>
References: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
 <1453803353-6266-6-git-send-email-jszhang@marvell.com>
Message-ID: <20160126183056.GH12716@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-01-26 at 06:15PM +0800, Jisheng Zhang wrote:
> sdhci_pltfm_unregister() could operate host's registers, it will cause
> problems if the clk is already disabled and unprepared. Fix this issue
> by moving the clk_disable_unprepare() call to the end of remove
> function.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
