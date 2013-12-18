From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 17 Dec 2013 23:14:57 -0800
Subject: [PATCH v4 0/9] Reuse davinci-nand driver for Keystone arch
In-Reply-To: <1387285155-19182-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1387285155-19182-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <20131218071457.GB5551@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 02:59:06PM +0200, Ivan Khoronzhuk wrote:
> This series contains fixes and updates of Davinci nand driver in
> order to reuse it for Keystone platform.
> 
> v3..v4:
> - mtd: nand: davinci: fix driver registration
> 	dropped __init/__exit/__exit_p as module_platform_driver() is used
> - mtd: nand: davinci: adjust DT properties to MTD generic
> 	used of_get_nand_bus_width() helper
> - mtd: nand: davinci: don't request AEMIF address range
> 	added comment at code change

Pushed the series to l2-mtd.git. Thanks!

Brian
