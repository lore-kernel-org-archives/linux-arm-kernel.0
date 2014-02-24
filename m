From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 24 Feb 2014 19:26:44 +0530
Subject: [PATCH V8 1/2] PHY: Exynos: Add Exynos5250 SATA PHY driver
In-Reply-To: <1393248775-3283-2-git-send-email-yuvaraj.cd@samsung.com>
References: <1393248775-3283-1-git-send-email-yuvaraj.cd@samsung.com>
 <1393248775-3283-2-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <530B4F9C.2050302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 24 February 2014 07:02 PM, Yuvaraj Kumar C D wrote:
> This patch adds the SATA PHY driver for Exynos5250.Exynos5250 SATA
> PHY comprises of CMU and TRSV blocks which are of I2C register Map.
> So this patch also adds a i2c client driver, which is used configure

We no longer have i2c client driver here.
> the CMU and TRSV block of exynos5250 SATA PHY.
> 
> This patch incorporates the generic PHY framework to deal with SATA
> PHY.

It should be rephrased to have *uses* generic PHY framework. However I feel we
can do away with this line.
> 
> This patch depends on the below patch for the sata functionality
> 	[1].ata: ahci_platform: Manage SATA PHY
> 		by Roger Quadros <rogerq@ti.com>

hasn't this patch merged yet?

Thanks
Kishon
