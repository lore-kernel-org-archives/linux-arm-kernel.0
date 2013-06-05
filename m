From: pavel@denx.de (Pavel Machek)
Date: Wed, 5 Jun 2013 22:31:25 +0200
Subject: [PATCHv6 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
In-Reply-To: <1370444578-25721-7-git-send-email-dinguyen@altera.com>
References: <1370444578-25721-1-git-send-email-dinguyen@altera.com>
 <1370444578-25721-7-git-send-email-dinguyen@altera.com>
Message-ID: <20130605203125.GB19905@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add platform specific functionality for the DW SD/MMC driver for
> SoCFPGA. Move SDMMC_CMD_USE_HOLD_REG to dw_mmc.h so other platforms
> can use this define.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

Reviewed-by: Pavel Machek <pavel@denx.de>

Thanks!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
