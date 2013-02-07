From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Feb 2013 14:39:59 +0000
Subject: [PATCH 1/2] ARM: dts: OMAP2+: Add SDMA controller bindings and
 nodes
In-Reply-To: <1360184596-1603-2-git-send-email-jon-hunter@ti.com>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
 <1360184596-1603-2-git-send-email-jon-hunter@ti.com>
Message-ID: <201302071440.00164.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 February 2013, Jon Hunter wrote:
> Add SDMA controller binding for OMAP2+ devices and populate DMA client
> information for SPI and MMC periperhal on OMAP3+ devices. Please note
> that OMAP24xx devices do not have SPI and MMC bindings available yet and
> so DMA client information is not populated.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
