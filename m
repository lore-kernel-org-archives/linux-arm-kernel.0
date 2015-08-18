From: mathieu@codeaurora.org (Mathieu Olivari)
Date: Tue, 18 Aug 2015 15:05:36 -0700
Subject: [PATCH 0/2] ARM: qcom: enable console output on IPQ806x
Message-ID: <1439935538-13932-1-git-send-email-mathieu@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change set adds uart nodes in ipq806x dtsi and add the chosen node
in AP148 dts file to use it as a console.

Mathieu Olivari (2):
  ARM: qcom: add uart labels to IPQ806x dts
  ARCH: qcom: enable uart output by default on AP148

 arch/arm/boot/dts/qcom-ipq8064-ap148.dts |  8 ++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi      | 15 +++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.1.4
