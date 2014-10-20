From: bonbons@linux-vserver.org (Bruno =?UTF-8?B?UHLDqW1vbnQ=?=)
Date: Mon, 20 Oct 2014 22:19:59 +0200
Subject: [RFC Patch 0/4] mfd: AXP20x: Add power supply sub-driver
Message-ID: <20141020221959.2f312906@neptune.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a power-supply driver to cover backup/RTC battery
charger, VBUS/OTG power in, AC power in and battery charger features
supported by AXP20x PMIC.

The DT bindings documentation patch depends on the following patch
from Carlo Caione:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/267604.html

Note, the reporting of some of the power supply interrupts might need
to be changed to dev_debug instead of dev_info.

For the DT bindings names they might need prefixing in which case
the corresponding prefix declaration patch from Carlo would be needed
as well:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/267606.html


Changes since initial posting on linux-sunxi:
 - A few typo fixes in strings/comments
 - Patch splitting

Bruno
