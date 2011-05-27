From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 May 2011 15:49:45 +0200
Subject: [PATCH v2] [media] at91: add Atmel Image Sensor Interface (ISI)
	support
In-Reply-To: <1306496329-14535-1-git-send-email-josh.wu@atmel.com>
References: <1306496329-14535-1-git-send-email-josh.wu@atmel.com>
Message-ID: <201105271549.46099.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 May 2011, Josh Wu wrote:
> This patch is to enable Atmel Image Sensor Interface (ISI) driver support.
> - Using soc-camera framework with videobuf2 dma-contig allocator
> - Supporting video streaming of YUV packed format
> - Tested on AT91SAM9M10G45-EK with OV2640
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Looks good to me now.

Acked-by: Arnd Bergmann <arnd@arndb.de>
