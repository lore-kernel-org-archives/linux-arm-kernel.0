From: vgarodia@codeaurora.org (Vikash Garodia)
Date: Mon, 23 Apr 2018 11:41:51 +0530
Subject: qcom: add firmware file for Venus on SDM845
Message-ID: <1524463911-19918-1-git-send-email-vgarodia@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

This pull request adds firmware files for Venus h/w codec found on the Qualcomm SDM845 chipset.

The following changes since commit b562d2f3583f19ecda22b08e514ced57dd1e5f4d:

  linux-firmware: update wil6210 firmware to 5.2.0.18 (2018-04-16 09:55:50 -0400)

are available in the git repository at:

  https://github.com/vgarodia/linux-firm.git master

for you to fetch changes up to ffd7e7cf5611f82cbbc614ae53ff16f54c1b2df2:

  qcom: add venus firmware files for v5.2 (2018-04-18 20:51:35 +0530)

----------------------------------------------------------------
Vikash Garodia (1):
      qcom: add venus firmware files for v5.2

 WHENCE                   |   9 +++++++++
 qcom/venus-5.2/venus.b00 | Bin 0 -> 212 bytes
 qcom/venus-5.2/venus.b01 | Bin 0 -> 6600 bytes
 qcom/venus-5.2/venus.b02 | Bin 0 -> 809040 bytes
 qcom/venus-5.2/venus.b03 | Bin 0 -> 33536 bytes
 qcom/venus-5.2/venus.b04 |   1 +
 qcom/venus-5.2/venus.mdt | Bin 0 -> 6812 bytes
 7 files changed, 10 insertions(+)
 create mode 100644 qcom/venus-5.2/venus.b00
 create mode 100644 qcom/venus-5.2/venus.b01
 create mode 100644 qcom/venus-5.2/venus.b02
 create mode 100644 qcom/venus-5.2/venus.b03
 create mode 100644 qcom/venus-5.2/venus.b04
 create mode 100644 qcom/venus-5.2/venus.mdt
