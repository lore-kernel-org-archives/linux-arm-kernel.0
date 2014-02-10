From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 10 Feb 2014 16:24:56 -0300
Subject: [PATCH 0/2] Armada 375/38x MBus support
Message-ID: <1392060298-27094-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of the submission of the Armada 375/38x initial support, these
two small patches add MBus support.

You will find that despite the MBus support being identical for the whole
SoC family: Armada 370/XP/375 and 38x, we have per-SoC compatible for each
of them.

Such decision is being currently discussed; see:

http://www.spinics.net/lists/arm-kernel/msg306480.html

Gregory CLEMENT (1):
  bus: mvebu-mbus: Add support for the Armada 375 SoCs

Thomas Petazzoni (1):
  bus: mvebu: Add support for the Armada 38x SoCs

 Documentation/devicetree/bindings/bus/mvebu-mbus.txt | 2 ++
 drivers/bus/mvebu-mbus.c                             | 4 ++++
 2 files changed, 6 insertions(+)

-- 
1.8.1.5
