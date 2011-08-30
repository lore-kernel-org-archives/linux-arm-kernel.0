From: davidb@codeaurora.org (David Brown)
Date: Tue, 30 Aug 2011 15:51:39 -0700
Subject: [GIT PULL] msm: initial devicetree support
Message-ID: <20110830225139.GA7093@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:

  Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-dt

David Brown (3):
      msm_serial: Use relative resources for iomem
      msm_serial: Add devicetree support
      ARM: msm: Add devicetree support for msm8660-surf

 .../devicetree/bindings/tty/serial/msm_serial.txt  |   27 +++++++++
 arch/arm/boot/dts/msm8660-surf.dts                 |   24 ++++++++
 arch/arm/mach-msm/board-msm8x60.c                  |   58 +++++++++++++++++---
 drivers/tty/serial/msm_serial.c                    |   30 +++++++----
 4 files changed, 122 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/msm_serial.txt
 create mode 100644 arch/arm/boot/dts/msm8660-surf.dts

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
