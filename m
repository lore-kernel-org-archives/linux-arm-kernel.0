From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 25 Apr 2016 18:38:54 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: enable SPI and NOR as modules
In-Reply-To: <1460681393-15000-1-git-send-email-khilman@baylibre.com>
References: <1460681393-15000-1-git-send-email-khilman@baylibre.com>
Message-ID: <571E16E6.6020305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2016 06:19 AM, Kevin Hilman wrote:
> Enable SPI driver and SPI NOR flash support as modules.
> 
> Tested with SPI NOR flash on DA850-EVM.  Basic boot test only to confirm
> NOR flash device detection.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
> Also boot tested on dm365-evm.
> 
> Tested on top of Sekhar's master branch, based on v4.6-rc1

Applied.

Thanks,
Sekhar
