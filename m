From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 28 Jul 2011 14:41:26 +0800
Subject: [PATCH v2 00/07] enable devicetree on arch-mmp
Message-ID: <1311835293-18125-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog
v2:
	* parse timer from DT
	* remove CONFIG_MMP_USE_OF
	* set NR_IRQS to 0 since sparse irq is enabled and allocated irq is started from NR_IRQS.
	* change property names according to comments
	* parse serial from DT and only use drivers/tty/serial/pxa.c. Avoid to touch drivers/tty/serial/of_serial.c
