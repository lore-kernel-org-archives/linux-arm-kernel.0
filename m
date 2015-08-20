From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 20 Aug 2015 17:19:05 +0800
Subject: [PATCH v2 0/4] Fixup mediatek spi driver 
Message-ID: <1440062349-25513-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series are based on 4.2-rc1 and provide four patches to fix mediatek spi driver.

Change in v2:
1. The patch "spi: mediatek: remove redundant clock in prepare_hardware/unprepare_hardware" 
   is applied, so remove it from series.
2. fix incorrect endian usage to support little-endian and big-endian system.
3. revise quirks style to bool.
4. use BIT() to instead of SPI_CMD_*_OFFSET.
5. revise coding style, such as time name, and variable type. 
