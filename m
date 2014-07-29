From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 29 Jul 2014 20:58:57 +0200
Subject: dma support for 8250-omap serial driver
Message-ID: <1406660344-25307-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series is on top of "[PATCH v4] 8250-core based serial driver for OMAP".
I will refresh it once I fixed the runtime-pm issue.
Patches 1-3 are independent of the series and just bug fixes. Patches 4+ are
RFC only for now. Its been tested on dra7, am33xx won't work as-is (even with
patch 5 providing dts nodes).

The complete series ontop of of v3.16-rc5 is also available at
	git://git.breakpoint.cc/bigeasy/linux.git uart_v5_dma

Sebastian
