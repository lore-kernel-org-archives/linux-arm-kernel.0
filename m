From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Apr 2014 15:37:37 +0200
Subject: [PATCH v8] mmc: moxart: Add MOXA ART SD/MMC driver
In-Reply-To: <1397051651-29501-1-git-send-email-jonas.jensen@gmail.com>
References: <1390301550-478-1-git-send-email-jonas.jensen@gmail.com>
 <1397051651-29501-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <201404231537.37396.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 April 2014, Jonas Jensen wrote:
> Add SD/MMC driver for MOXA ART SoCs.
> 
> The "MOXA ART MMC controller" is likely a faraday "ftsdc010",
> a controller with support in U-Boot:
> 
> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/mmc/ftsdc010_mci.c
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
