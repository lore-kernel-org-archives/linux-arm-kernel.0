From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue,  6 Mar 2018 18:35:00 +0530
Subject: [PATCH 0/3] Enable thermal management on MSM8916
Message-ID: <cover.1520340931.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT entries to create cooling devices on MSM8916, enable the thermal
sensor on the platform and turn on other cpufreq governors to make it easy
for developers.

This patchset requires
http://patchwork.kernel.org/bundle/amitkucheria/8016-cpufreq-dts/ to be
applied first to enable thermal functionality by cpu frequency throttling.

Amit Kucheria (2):
  arm64: defconfig: enable thermal sensor on QCOM platforms
  arm64: defconfig: enable more cpufreq governors

Rajendra Nayak (1):
  arm64: dts: msm8916: Add cpu cooling maps

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 31 +++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig          | 10 ++++++++++
 2 files changed, 41 insertions(+)

-- 
2.7.4
