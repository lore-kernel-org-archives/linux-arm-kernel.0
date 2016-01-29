From: B56489@freescale.com (Yunhui Cui)
Date: Fri, 29 Jan 2016 19:41:06 +0800
Subject: [PATCH 0/3] mtd:fsl-quadspi:add support for the flash on LS1021ATWR
Message-ID: <1454067669-35274-1-git-send-email-B56489@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set depend on the patch:
{
https://patchwork.ozlabs.org/patch/545926/

LS1021a also support Freescale Quad SPI controller.
Add fsl-quadspi support for ls1021a chip and make SPI_FSL_QUADSPI
selectable for LS1021A SOC hardwares.
}

There is a N25Q128 flash on LS1021ATWR.
This patch test on this flash on LS1021ATWR board.
