From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sat, 25 Jun 2016 22:52:10 -0700
Subject: [PATCH 0/3] Update pm8941 spmi regulators for USB OTG
Message-ID: <20160626055213.18071-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While rewriting the USB support for MSM SoCs I ran into a few
minor bugs with the pm8941 regulator driver that hadn't been found
before. These patches are part of a larger series that allows me
to get proper USB OTG support working on the apq8074 dragonboard.

Stephen Boyd (3):
  regulator: qcom_spmi: Add support for S4 supply on pm8941
  regulator: qcom_spmi: Update mvs1/mvs2 switches on pm8941
  regulator: qcom_spmi: Add support for get_mode/set_mode on switches

 .../devicetree/bindings/regulator/qcom,spmi-regulator.txt          | 6 +++---
 drivers/regulator/qcom_spmi-regulator.c                            | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.9.0.rc2.8.ga28705d
