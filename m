From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jan 2017 13:35:28 +0000
Subject: [PATCH 0/5] ARM: qcom_defconfig: Add configs required for IFC6410
Message-ID: <1483536933-21503-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds configs required to get USB, SATA, PCIE, and tsens work on
top of mainline on APQ8064 based IFC6410 and SD-600EVAL board.

Srinivas Kandagatla (5):
  ARM: qcom_defconfig: enable qcom rpm clk controller
  ARM: qcom_defconfig: add usb related configs
  ARM: qcom_defconfig: add pcie and atl1c ethernet configs
  ARM: qcom_defconfig: add ahci configs
  ARM: qcom_defconfig: enable thermal sensors

 arch/arm/configs/qcom_defconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--
2.10.1
