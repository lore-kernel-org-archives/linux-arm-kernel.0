From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 4 Sep 2017 13:55:09 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: enable MTD_CMDLINE_PARTS
In-Reply-To: <1504277599-12812-1-git-send-email-aford173@gmail.com>
References: <1504277599-12812-1-git-send-email-aford173@gmail.com>
Message-ID: <cb31f8be-c3d0-24f3-4eb3-a23d5cdbb0bb@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 September 2017 08:23 PM, Adam Ford wrote:
> There is some disagreement between the partition table map in Linux
> for the DA850-EVM and the coresponding partition map in U-Boot.

corresponding spelling fixed.

> To prevent breaking the Kernel, this patch enables MTD_CMDLINE_PARTS
> which will allow the U-Boot to pass the partition map so future partitions
> match without breaking backwards compatibility.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

And noted CONFIG_MMC_BLOCK_BOUNCE removal is because of savedefconfig sync.

Applied for v4.15.

Thanks,
Sekhar
