From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 May 2013 19:10:37 +0200
Subject: [PATCHv4 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
In-Reply-To: <1369410080-436-6-git-send-email-dinguyen@altera.com>
References: <1369410080-436-1-git-send-email-dinguyen@altera.com>
 <1369410080-436-6-git-send-email-dinguyen@altera.com>
Message-ID: <201305241910.37975.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 May 2013, dinguyen at altera.com wrote:
> 
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add platform specific functionality for the DW SD/MMC driver for
> SoCFPGA. Move SDMMC_CMD_USE_HOLD_REG to dw_mmc.h so other platforms
> can use this define.

No objections to the patch, but you seem to be missing a  binding document,
which is mandatory to describe the properties you add.

It also seems odd to have this in the series for the ethernet driver.

	Arnd
