From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 6 Oct 2014 23:44:04 -0700
Subject: [PATCH 0/2] mtd: nand: omap: Fix build with
 CONFIG_MTD_NAND_OMAP_BCH=m
In-Reply-To: <1412163210-12948-1-git-send-email-rogerq@ti.com>
References: <1412163210-12948-1-git-send-email-rogerq@ti.com>
Message-ID: <20141007064404.GA22169@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 02:33:28PM +0300, Roger Quadros wrote:
> Hi,
> 
> Patch 1 fixes build with OMAP nand driver as built-in and the BCH driver as a module.
> Ezequiel, I took the liberty to address an issue with your original patch so this is v2.
> 
> Patch 2 fixes the help message for CONFIG_MTD_NAND_OMAP_BCH to avoid user confusion.
> CONFIG_MTD_NAND_OMAP_BCH is optional but doesn't harm on legacy OMAP platforms not having
> the ELM/BCH hardware.

Thanks for finishing these off properly. Pushed to l2-mtd.git.

Briarn
