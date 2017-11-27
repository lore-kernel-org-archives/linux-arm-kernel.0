From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Mon, 27 Nov 2017 11:44:55 +0000
Subject: [PATCH 0/3] ARM: qcom_defconfig: display related configs.
Message-ID: <20171127114458.20976-1-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Andy, 
Here are some Kconfig options that are required to test display on 8064.

Without which we have to manually enable these configs for display testing
based on mainline.

Thanks,
srini

Srinivas Kandagatla (3):
  ARM: qcom_defconfig: Enable DRM for 8064 display
  ARM: qcom_defconfig: enable MSM IOMMU for display
  ARM: qcom_defconfig: Enable Frambuffer console support

 arch/arm/configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.15.0
