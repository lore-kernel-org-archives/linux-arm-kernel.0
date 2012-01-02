From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 02 Jan 2012 09:54:03 +0900
Subject: [GIT PULL] Samsung devel-rtc for v3.3
Message-ID: <037601ccc8e9$07e2c8e0$17a85aa0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull Samsung devel-rtc for v3.3 from following.
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-devel-rtc

It is including support rtc for S3C2443 and S3C2416 and got the ack from
Alessandro Zummo.

Since next-samsung-dt1 branch touch drivers/rtc, it has been made based on
next-samsung-dt1 branch.

If any problems please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 0561ceabd0f13871900d116278fe9268aeb714d1:

  ARM: dts: Add intial dts file for EXYNOS4210 SoC, SMDKV310 and ORIGEN
(2011-12-23 10:07:12 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-devel-rtc

Heiko Stuebner (4):
      ARM: SAMSUNG: cleanup of rtc register definitions
      rtc-s3c: make room for more variants in devicetree block
      rtc-s3c: add variants for S3C2443 and S3C2416
      ARM: S3C2443/S3C2416: add s3c_rtc_setname and rename rtc devices

 arch/arm/mach-s3c2416/s3c2416.c               |    2 +
 arch/arm/mach-s3c2443/s3c2443.c               |    2 +
 arch/arm/plat-samsung/include/plat/regs-rtc.h |   81
+++++++++++++------------
 arch/arm/plat-samsung/include/plat/rtc-core.h |   27 ++++++++
 drivers/rtc/rtc-s3c.c                         |   71 ++++++++++++++++++----
 5 files changed, 131 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/rtc-core.h
