From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Dec 2013 17:28:07 +0100
Subject: [PATCHv5 2/4] clk: socfpga: Add a hook for SD/MMC driver to
 control CIU clock settings
In-Reply-To: <1386597462-29471-3-git-send-email-dinguyen@altera.com>
References: <1386597462-29471-1-git-send-email-dinguyen@altera.com>
 <1386597462-29471-3-git-send-email-dinguyen@altera.com>
Message-ID: <201312091728.07940.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Populate the .prepare function in the clk-ops for the "sdmmc_clk" that represents
> the "ciu" clock for the SD/MMC driver. The prepare function will handle setting
> the correct clock-phase for the CIU clock of the SD/MMC IP.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

Please see my comments for this patch for v4, it still looks wrong to me.
The other three patches are good though.

	Arnd
