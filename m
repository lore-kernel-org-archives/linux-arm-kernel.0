From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 8 Dec 2009 15:32:39 -0800
Subject: [PATCH 0/5] spi-imx: some updates
In-Reply-To: <20091208211258.GA13706@pengutronix.de>
References: <20091208211258.GA13706@pengutronix.de>
Message-ID: <20091208153239.af0b5bb8.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Dec 2009 22:12:58 +0100
Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:

> this series depends on "spi: drain MXC SPI transfer buffer when probing
> device" which is currently in -mm and also included in my spi-imx branch
> (see below).  IMHO at least my first patch should go into .33 as it
> fixes an oops.

I queued all five for 2.6.33.


Once I've merged up the current -mm patch queue:

atmel_spi-fix-dma-addr-calculation-for-len-buffer_size.patch
spi-controller-driver-for-designware-spi-core.patch
#
spi-add-pci-interface-driver-for-designware-spi-core.patch
spi-add-pci-interface-driver-for-designware-spi-core-fix.patch
spi-controller-driver-for-designware-spi-core-fix.patch
#
spidev-add-proper-section-markers.patch
spidev-use-declare_bitmap-instead-of-declaring-the-array.patch
spidev-use-declare_bitmap-instead-of-declaring-the-array-checkpatch-fixes.patch
spi-drain-mxc-spi-transfer-buffer-when-probing-device.patch
spi_s3c24xx-add-fiq-pseudo-dma-support.patch
spi-superh-msiof-spi-master-driver.patch
spi-superh-msiof-spi-master-driver-update.patch
spi-nuc900-add-arm-driver-support-for-nuc900.patch
spi-fix-spidev-compilation-failure-when-verbose-is-defined.patch
#
spi-imx-use-platform_driver_probe-as-probe-lives-in-inittext.patch
spi-imx-correct-check-for-platform_get_irq-failing.patch
spi-imx-use-positive-logic-to-distinguish-cpu-variants.patch
spi-imx-add-mx25-support.patch
spi-imx-dont-access-struct-device-directly-but-use-dev_get_platdata.patch


I shall stop sending SPI patches to Linus.  I'll send any which I
accumulate to Grant instead.
