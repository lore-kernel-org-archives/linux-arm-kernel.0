From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed,  7 Jan 2015 12:39:28 +0530
Subject: [PATCH 0/2] Add SNVS clock gating and SNVS node for DT
Message-ID: <cover.1420612799.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch set adds support for clock gating
of the SNVS peripheral required on the Vybrid platform.
Also adds a device tree node for this peripheral.

This patchset was send before along with the patch which
had clock changes to the rtc-snvs driver. Since these could
not be merged then, till the changes for rtc-snvs landed in
the mainline, I am sending them anew as the changes are now
in the for-next branch
https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/log/?h=for-next

The initial discussion can be found at the below links for the
earlier set of patches:

[RESEND] v2:
https://lkml.org/lkml/2014/12/3/23

v2:
https://lkml.org/lkml/2014/11/7/295

v1:
https://lkml.org/lkml/2014/9/26/492

Sanchayan Maity (2):
  ARM: imx: clk-vf610: Add clock for SNVS
  ARM: dts: vfxxx: Add SNVS node

 arch/arm/boot/dts/vf500.dtsi            |    4 ++++
 arch/arm/boot/dts/vfxxx.dtsi            |   14 ++++++++++++++
 arch/arm/mach-imx/clk-vf610.c           |    2 ++
 include/dt-bindings/clock/vf610-clock.h |    3 ++-
 4 files changed, 22 insertions(+), 1 deletion(-)

-- 
1.7.9.5
