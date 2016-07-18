From: michael.weiser@gmx.de (Michael Weiser)
Date: Mon, 18 Jul 2016 18:23:52 +0200
Subject: [PATCH 0/3] Fixes for running a big-endian kernel on Cubieboard2
Message-ID: <20160718162355.20273-1-michael.weiser@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the following patches fix up endianness problems with DMA descriptors in the
sunxi-mmc and stmmac drivers preventing a big-endian kernel from working
correctly on the Cubieboard2. The final patch enables the big-endian kernel
configuration option for sunxi devices in order to be able to compile a
big-endian kernel for the Cubieboard2. All of these have been tested
successfull on a Cubieboard2 Dual-Card.

Regards,
Michael

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
