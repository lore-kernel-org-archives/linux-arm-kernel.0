From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Jun 2013 16:27:56 -0700
Subject: [PATCHv6 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
In-Reply-To: <1370444578-25721-7-git-send-email-dinguyen@altera.com>
References: <1370444578-25721-1-git-send-email-dinguyen@altera.com>
 <1370444578-25721-7-git-send-email-dinguyen@altera.com>
Message-ID: <20130611232756.GD23774@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 05, 2013 at 10:02:58AM -0500, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add platform specific functionality for the DW SD/MMC driver for
> SoCFPGA. Move SDMMC_CMD_USE_HOLD_REG to dw_mmc.h so other platforms
> can use this define.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> CC: Seungwon Jeon <tgih.jun@samsung.com>
> CC: Jaehoon Chung <jh80.chung@samsung.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Olof Johansson <olof@lixom.net>
> CC: Pavel Machek <pavel@denx.de>
> CC: linux-mmc at vger.kernel.org

Acked-by: Olof Johansson <olof@lixom.net>

This one should be sent to (and applied by) Chris Ball, the MMC maintainer. The
driver is standalone and can go in independently on the platform code that will
configure it, so he can merge it without dependencies.


-Olof
