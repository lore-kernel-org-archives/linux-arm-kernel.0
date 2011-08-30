From: davidb@codeaurora.org (David Brown)
Date: Tue, 30 Aug 2011 15:52:13 -0700
Subject: [GIT PULL] msm: devboard defconfigs
Message-ID: <20110830225213.GB7093@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unless Russell objects, and prefers these to be in his tree, I'm fine
with having these in a branch for linux-next that isn't merged
upstream for now.

The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:

  Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-defconfig

David Brown (1):
      ARM: msm: defconfigs for Qualcomm dev boards

 arch/arm/configs/msm7x30_defconfig |   68 +++++++++
 arch/arm/configs/msm8660_defconfig |   96 +++++++++++++
 arch/arm/configs/msm8960_defconfig |  265 ++++++++++++++++++++++++++++++++++++
 arch/arm/configs/qsd8x50_defconfig |   82 +++++++++++
 4 files changed, 511 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/msm7x30_defconfig
 create mode 100644 arch/arm/configs/msm8660_defconfig
 create mode 100644 arch/arm/configs/msm8960_defconfig
 create mode 100644 arch/arm/configs/qsd8x50_defconfig

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
