From: s-anna@ti.com (Suman Anna)
Date: Thu, 31 May 2018 12:10:58 -0500
Subject: [PATCH 0/5] rpmsg: Convert to use SPDX license identifiers
Message-ID: <20180531171103.8703-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

The following series switches over the current licensing text in
various rpmsg drivers to the SPDX licensing format. I see that you
have already picked up my series for the HwSpinlock drivers, so this
series does the same for the rpmsg drivers. Please pick these as well
for 4.18. Patches done on top of latest upstream kernel.

regards
Suman

Suman Anna (5):
  rpmsg: Switch to SPDX license identifier
  rpmsg: virtio_rpmsg_bus: Switch to SPDX license identifier
  rpmsg: smd: Switch to SPDX license identifier
  rpmsg: glink: Switch to SPDX license identifier
  rpmsg: char: Switch to SPDX license identifier

 drivers/rpmsg/Kconfig             |  2 ++
 drivers/rpmsg/qcom_glink_native.c | 10 +---------
 drivers/rpmsg/qcom_glink_native.h | 10 +---------
 drivers/rpmsg/qcom_glink_rpm.c    | 10 +---------
 drivers/rpmsg/qcom_glink_smem.c   | 10 +---------
 drivers/rpmsg/qcom_smd.c          | 10 +---------
 drivers/rpmsg/rpmsg_char.c        | 10 +---------
 drivers/rpmsg/rpmsg_core.c        | 10 +---------
 drivers/rpmsg/rpmsg_internal.h    | 10 +---------
 drivers/rpmsg/virtio_rpmsg_bus.c  | 10 +---------
 include/linux/rpmsg.h             | 27 +--------------------------
 include/linux/rpmsg/qcom_glink.h  |  2 ++
 include/uapi/linux/rpmsg.h        |  9 ---------
 13 files changed, 14 insertions(+), 116 deletions(-)

-- 
2.17.0
