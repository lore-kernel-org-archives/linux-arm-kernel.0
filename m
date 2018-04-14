From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat, 14 Apr 2018 08:48:10 +0530
Subject: [PATCH 0/1] Add gpio-line-names property for Dragonboard820c
Message-ID: <20180414031811.11351-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio-line-names property for 96Boards Dragonboard820c development
board based on APQ8096 SoC. The lines are named after the 96Boards
CE Specification 1.0, Appendix "Expansion Connector Signal Description".
There are 4 gpio-controllers present on this board, including the
APQ8096 SoC, PM8994 (GPIO, MPP) and PMI8994 (GPIO).

Considering the regular 96Boards Consumer Edition boards, this board belongs
to Entended edition form factor, hence includes additional Primary,
Secondary High Speed Connectors and one Camera Connector.

Line names for PMI8994 MPP pins are not added due to the absence of the
gpio-controller support.

Manivannan Sadhasivam (1):
  dts: qcom: db820c: Add gpio-line-names property

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 240 +++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

-- 
2.14.1
