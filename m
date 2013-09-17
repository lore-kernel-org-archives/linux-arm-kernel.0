From: pavel@denx.de (Pavel Machek)
Date: Tue, 17 Sep 2013 23:51:15 +0200
Subject: [PATCH] arm: socfpga: Fix incorrect sdmmc clock name
In-Reply-To: <1379434985-25294-1-git-send-email-dinguyen@altera.com>
References: <1379434985-25294-1-git-send-email-dinguyen@altera.com>
Message-ID: <20130917215115.GA23937@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2013-09-17 11:23:05, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The SD/MMC clock is named "sdmmc_clk", and NOT "mmc_clk". Because of this,
> the SD driver was getting the incorrect clock value. This prevented the
> SD driver from initializing correctly.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Olof Johansson <olof@lixom.net>

Reviewed-by: Pavel Machek <pavel@denx.de>

Thanks!
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
