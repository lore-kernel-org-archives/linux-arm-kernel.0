From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Jun 2017 10:37:47 +0200
Subject: [PATCH 0/6] Update binding documentation for cp110 and ap806
Message-ID: <20170620083754.28053-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

As you know there were dependencies issue about the binding between my
different series and you proposed yourself to apply them though the
device tree subsystem: [1]

All the driver parts have been merged so it's time merging the
documentation.

Thanks,

Gregory

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/509643.html

Gregory CLEMENT (6):
  dt-bindings: cp110: do not depend anymore of the *-clock-output-names
  dt-bindings: cp110: introduce a new binding
  dt-bindings: cp110: add sdio clock to cp-110 system controller
  pinctrl: dt-bindings: add documentation for AP806 pin controllers
  pinctrl: dt-bindings: add documentation for CP110 pin controllers
  gpio: dt-bindings: Add documentation for gpio controllers on Armada
    7K/8K

 .../arm/marvell/ap806-system-controller.txt        |  73 ++++++++++-
 .../arm/marvell/cp110-system-controller0.txt       | 144 ++++++++++++++++++---
 .../devicetree/bindings/gpio/gpio-mvebu.txt        |  24 +++-
 3 files changed, 208 insertions(+), 33 deletions(-)

-- 
2.11.0
