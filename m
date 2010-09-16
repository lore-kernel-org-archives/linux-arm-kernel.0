From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Thu, 16 Sep 2010 06:18:49 -0700
Subject: spi: amba_pl022: driver and platform spi->mode fixes
Message-ID: <1284643130-17659-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a merge of the previously posted and reviewed
patch series:
	amba_pl022: Setup SPI configuration based on spi->mode
	amba_pl022 spi->mode fix/cleanup patches

It also fixes an incorrect bit assignment for SPHA mode.

This patch can be pulled from:
	git pull git://git.lpclinux.com/linux-2.6-lpc amba_pl022_spimode
