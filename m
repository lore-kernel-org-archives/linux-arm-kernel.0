From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun,  1 Oct 2017 22:06:15 -0400
Subject: [PATCH 0/3] a few debug_ll fixes and improvements
Message-ID: <20171002020618.23924-1-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This includes a couple fixes and improvements for using the early console
with semihosting on a v7m processor.


 arch/arm/boot/compressed/debug.S |  4 ++++
 arch/arm/kernel/debug.S          | 22 +++++++++++++++++++---
 arch/arm/kernel/early_printk.c   | 16 ++++++++++------
 3 files changed, 33 insertions(+), 9 deletions(-)
