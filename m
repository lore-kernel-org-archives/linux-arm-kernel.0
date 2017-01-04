From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jan 2017 13:34:56 +0000
Subject: [PATCH 0/6] arm64: dts: DB410c and DB820c dt patches
Message-ID: <1483536902-21450-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches to add support to digital audio, Coresight, Volume up Key on DB410c.
and a Fix and adds Volume up key for DB820c.

Ivan T. Ivanov (3):
  arm64: dts: apq8016-sbc: Add Volume Up key device node
  arm64: dts: apq8016-sbc: Limit MPP4 high state to 1.8V
  arm64: dts: msm8916: Add CoreSight components

Srinivas Kandagatla (3):
  arm64: dts: db820c: fix gpio pinctrl name correctly
  arm64: dts: apq8016-sbc: add support to hdmi audio via adv7533
  arm64: dts: db820c: add support to volume up key

 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi |  13 ++
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi |  13 ++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  28 +++
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    |  14 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |  19 ++
 arch/arm64/boot/dts/qcom/msm8916-coresight.dtsi    | 254 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   3 +-
 7 files changed, 342 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-coresight.dtsi

--
2.10.1
