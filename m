From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 10 Mar 2010 17:41:17 +0100
Subject: [PATCH 2/4] Driver for Zipit Z2 battery chip
Message-ID: <201003101741.17840.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This patch adds driver for Zipit Z2 battery chip called AER915. No
details are known about the chip. The chip is available through I2C bus
at address 0x55 and it's register 0x02 contains battery voltage.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0006-Driver-for-Zipit-Z2-battery-chip.patch
Type: text/x-patch
Size: 10862 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100310/c3a69355/attachment-0001.bin>
