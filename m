From: ttnguyen@apm.com (Tai Nguyen)
Date: Tue,  2 Jun 2015 12:19:05 -0700
Subject: [PATCH 0/2 RESEND] power: reset: Add syscon reboot/poweroff device
 nodes for APM X-Gene platform
Message-ID: <1433272747-27114-1-git-send-email-ttnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds syscon reboot/poweroff device nodes to support reboot and
poweroff features on X-Gene platform. 

Tai Nguyen (2):
  power: reset: Add syscon reboot device node for APM X-Gene platform
  power: reset: Add syscon poweroff device node for APM X-Gene Mustang platform

 arch/arm64/boot/dts/apm/apm-mustang.dts |   12 ++++++++++++
 arch/arm64/boot/dts/apm/apm-storm.dtsi  |   12 ++++++++++++
 2 files changed, 24 insertions(+)

-- 
1.7.9.5
