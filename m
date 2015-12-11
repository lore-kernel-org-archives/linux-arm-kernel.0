From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 11 Dec 2015 18:26:49 +0000
Subject: [PATCH 0/4] arm: dts: qcom-apq8064: add smem and hwspinlock support
Message-ID: <1449858409-13296-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy, 

Here are 3 patches for smem/hwspinlock which I have tested with QDSP on IFC6410.
Also a fix from Ivan which I think can be taken aswell.

Thanks,
srini

Ivan T. Ivanov (1):
  ARM: dts: qcom: apq8064-ifc6410 Use hardware flow control for GSBI6

Srinivas Kandagatla (3):
  arm: dts: apq8064: add shared memory into dt reserved-memory
  arm: dts: apq8064: add hwspinlock nodes
  arm: dts: apq8064: add shared memory node

 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |  2 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

-- 
1.9.1
