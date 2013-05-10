From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 10 May 2013 12:25:05 +0530
Subject: [PATCH] ARM: exynos: defconfig update
In-Reply-To: <1368133099-16997-1-git-send-email-olof@lixom.net>
References: <1368133099-16997-1-git-send-email-olof@lixom.net>
Message-ID: <518C99C9.1000708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2013 02:28 AM, Olof Johansson wrote:
> This turns on a number of configs that are useful on the Chromebook, but also
> good to have on in general:
> 
> * USB host and MMC drivers(!)
> * I2C GPIO arbitration driver
> * CYAPA trackpad driver
> * simplefb
> * CROS EC and keyboard drivers
> * MAX77686 drivers
> * DEVTMPFS + mount
> * DM_CRYPT (as module)
> * CRYPTOLOOP
> * HIGHMEM
> * PRINTK timestamps
> 
> This also turns off DEBUG_LL, and switches the hardcoded Samsung lowlevel
> uart to uart 3 (which is only used to show the "uncompressing kernel"
> message at boot, it seems).
> 

Setting the UART to 2, I tested this to work well with Arndale board.
Though, I would also like to enable S5M8767 driver (for Arndale board),
MAX8997 driver and MMC SDHCI driver (for Origen board). I will be
sending a patch to enable them.

> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Tested-by: Tushar Behera <tushar.behera@linaro.org>

-- 
Tushar Behera
