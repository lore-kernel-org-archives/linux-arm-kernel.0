From: inki.dae@samsung.com (InKi Dae)
Date: Tue, 29 Jun 2010 17:31:46 +0900
Subject: [PATCH 0/3] ARM: S5PV210: Add MIPI-DSI support.
Message-ID: <4C29AF72.6090200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

This patch is for MIPI-DSI controller based on S5PV210 (or S5PC110).

LCD Panel can use following interfaces,
- RGB or CPU Interface.
- RGB or CPU Interface based on MIPI-DSI.

In case of small size lcd panel, it was ok only rgb or cpu interface not
using mipi controller.
But big size panel(more then 480x800) needs MIPI-DSI Interface or other
hardwares like LVDS
To transfer image data to lcd panel fine.

I tested this patch on cpu interface based on MIPI so for this patch,
Some mainline codes should be modified and also considered RGB interface.

This patch set consists of the following patches,

[PATCH 1/3] FB: Add some members for CPU Interface.
[PATCH 2/3] S5PV210: FB: Add MIPI-DSI and CPU Interface features.
[PATCH 3/3] S5PV210: Add MIPI-DSI Driver.

Best regards,
InKi Dae
