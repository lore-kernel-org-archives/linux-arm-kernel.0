From: nicolas.dechesne@linaro.org (Nicolas Dechesne)
Date: Wed, 15 Nov 2017 21:00:49 +0100
Subject: qcom: add firmware file for Adreno and Venus on APQ8096
Message-ID: <CAP71Wjw-3FrOtHADuui52t+iqv6QkvXXCthjR6akXr7QQTzrAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

This pull request adds firmware files for Adreno 530 GPU and Venus h/w
codec found on the Qualcomm APQ8096 chipset, such as on Dragonboard
820c development board.

The following changes since commit bf04291309d3169c0ad3b8db52564235bbd08e30:

  WHENCE: Add new qed firmware (2017-10-09 18:03:26 +0100)

are available in the git repository at:

  https://github.com/ndechesne/linux-firmware.git db820c

for you to fetch changes up to e7219334854d854ae7768b13dc290ec85d93a0d9:

  qcom: add venus firmware files for v4.2 (2017-11-15 20:49:17 +0100)

----------------------------------------------------------------
Nicolas Dechesne (2):
      qcom: add firmware files for Adreno a530
      qcom: add venus firmware files for v4.2

 WHENCE                   |  16 ++++++++++++++++
 qcom/a530_pfp.fw         | Bin 0 -> 15876 bytes
 qcom/a530_pm4.fw         | Bin 0 -> 19572 bytes
 qcom/a530_zap.b00        | Bin 0 -> 148 bytes
 qcom/a530_zap.b01        | Bin 0 -> 6536 bytes
 qcom/a530_zap.b02        | Bin 0 -> 4900 bytes
 qcom/a530_zap.mdt        | Bin 0 -> 6684 bytes
 qcom/a530v3_gpmu.fw2     | Bin 0 -> 8184 bytes
 qcom/venus-4.2/venus.b00 | Bin 0 -> 212 bytes
 qcom/venus-4.2/venus.b01 | Bin 0 -> 6600 bytes
 qcom/venus-4.2/venus.b02 | Bin 0 -> 884136 bytes
 qcom/venus-4.2/venus.b03 | Bin 0 -> 28976 bytes
 qcom/venus-4.2/venus.b04 |   1 +
 qcom/venus-4.2/venus.mdt | Bin 0 -> 6812 bytes
 14 files changed, 17 insertions(+)
 create mode 100644 qcom/a530_pfp.fw
 create mode 100644 qcom/a530_pm4.fw
 create mode 100644 qcom/a530_zap.b00
 create mode 100644 qcom/a530_zap.b01
 create mode 100644 qcom/a530_zap.b02
 create mode 100644 qcom/a530_zap.mdt
 create mode 100644 qcom/a530v3_gpmu.fw2
 create mode 100644 qcom/venus-4.2/venus.b00
 create mode 100644 qcom/venus-4.2/venus.b01
 create mode 100644 qcom/venus-4.2/venus.b02
 create mode 100644 qcom/venus-4.2/venus.b03
 create mode 100644 qcom/venus-4.2/venus.b04
 create mode 100644 qcom/venus-4.2/venus.mdt
