From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 1 Aug 2014 16:15:47 +0300
Subject: [PATCH 0/1] ARM: OMAP: add external clock provider support
Message-ID: <1406898948-26113-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch adds possibility to register external clocks (outside the main
SoC) on TI boards through device tree. Clock sources as such include for
example twl-6030 / twl-6040 chips and variants which can be used to clock
for example audio / WLAN chips.

This patch can be queued once someone has a use-case + patches that requires
usage of such clocks.

-Tero
