From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 22:48:10 -0700
Subject: [PATCH] arm: socfpga: Fix incorrect sdmmc clock name
In-Reply-To: <1376322134-17408-1-git-send-email-dinguyen@altera.com>
References: <1376322134-17408-1-git-send-email-dinguyen@altera.com>
Message-ID: <20130814054810.GF16635@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 10:42:14AM -0500, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The SD/MMC clock is named "sdmmc_clk", and NOT "mmc_clk".
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Olof Johansson <olof@lixom.net>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: linux-arm-kernel at lists.infradead.org

Hi Dinh,

Do you want this applied in fixes for 3.11? If so, can you give me a oneliner
on what the impact here is? mmc doesn't come up at all, or something more
subtle?


-Olof
