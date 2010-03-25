From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 25 Mar 2010 12:15:11 +0100
Subject: [PATCH] Add support for Aquita board (Samsung S5PC110 based)
Message-ID: <1269515719-18519-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series add basic support for Samsung Aquila board. The board
is based on Samsung S5PC110 SoC. For the basic support of this board, the
S5PV210/S5PC110 platform core needs to be updated. This patch series
contains patches that add support for gpiolib, software reset and
framebuffer helpers. Please expect further extensions to the s5pv210
platform core soon.

This patch series includes:

[PATCH 1/8] ARM: S5PV210: fix formating of the debug messages on boot
[PATCH 2/8] ARM: S5PV210: add support for software reset
[PATCH 3/8] ARM: S5PV210: add gpiolib support
[PATCH 4/8] ARM: Samsung: move driver strength gpio configuration helper to common dir
[PATCH 5/8] ARM: S5PV210: add Aquila board
[PATCH 6/8] ARM: Samsung: move common framebuffer regs to common platform directory
[PATCH 7/8] ARM: S5PV210: add framebuffer platform helpers for s5pv210 based machines
[PATCH 8/8] ARM: S5PV210: add support for s3c-fb driver on Aquila machine
