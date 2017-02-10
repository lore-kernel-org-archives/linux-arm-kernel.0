From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 10 Feb 2017 16:29:36 +0100
Subject: Enable DMA for daVinci SPI controller
Message-ID: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DMA for the daVinci SPI using the SPI framework DMA mapping
function. Also, add some extra options to the spi-loopback-test
module to catch errors caused by many SG entries.
This has been tested using spidev_test, spi-loopback-test and
mounting and read/write UBIFS volume over SPI flash.

In-Reply-To: 
