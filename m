From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed,  8 Jul 2015 16:51:05 -0400
Subject: [PATCH 0/1] Add support for esdhc0 on Vybrid.
Message-ID: <1436388666-29376-1-git-send-email-cory.tusar@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, only esdhc1 is described in vfxxx.dtsi.  This quick patch
adds support for esdhc0 also.

Regards,
-Cory


Cory Tusar (1):
  ARM: dts: vfxxx: Include support for esdhc0 functionality.

 arch/arm/boot/dts/vfxxx.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.3.6
