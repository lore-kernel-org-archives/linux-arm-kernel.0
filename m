From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 13 Jul 2015 12:34:52 -0500
Subject: [PATCH v4 0/3] ARM: OMAP2+: wkup_m3_rproc support patches
Message-ID: <1436808895-21206-1-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Now that wkup_m3_rproc driver [1] has been merged the support code
contained in this series can be merged. This is v4 which is just a
rebase of v3 [2] code on v4.2-rc2, no other changes.

Regards,
Dave

[1] http://www.spinics.net/lists/linux-omap/msg118768.html
[2] http://www.spinics.net/lists/linux-omap/msg117614.html

Dave Gerlach (1):
  ARM: OMAP2+: Use pdata-quirks for wkup_m3 reset management

Suman Anna (2):
  ARM: dts: AM33xx: Update and move wkup_m3 node to l4 node
  ARM: dts: AM4372: Add the wkupm3 rproc node

 arch/arm/boot/dts/am33xx.dtsi      | 17 +++++++++--------
 arch/arm/boot/dts/am4372.dtsi      |  9 +++++++++
 arch/arm/mach-omap2/pdata-quirks.c | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 8 deletions(-)

-- 
2.4.5
