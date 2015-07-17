From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 17 Jul 2015 16:08:00 -0500
Subject: [PATCH 0/4] ARM: dts: am335x/am43xx: wkup_m3_ipc support patches
Message-ID: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds the necessary dt nodes for the wkup_m3_ipc on am335x
and am437x and also adds the ti,mbox-send-noirq flag to the wkup_m3
mailbox on both platforms as well so that we can use mailbox from
noirq context when needed. This series is to make use of the
driver introduced here [1].

Regards,
Dave

[1] http://www.spinics.net/lists/arm-kernel/msg432612.html

Dave Gerlach (1):
  ARM: dts: AM33xx: Add ti,mbox-send-noirq to wkup_m3 mailbox

Keerthy (1):
  ARM: dts: AM4372: Add ti,mbox-send-noirq to wkup_m3 mailbox

Suman Anna (2):
  ARM: dts: AM33xx: Add the wkup_m3_ipc node
  ARM: dts: AM4372: Add the wkup_m3_ipc node

 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
 arch/arm/boot/dts/am4372.dtsi | 9 +++++++++
 2 files changed, 18 insertions(+)

-- 
2.4.5
