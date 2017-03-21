From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Mar 2017 16:52:58 +0800
Subject: [PATCH 0/3] arm64: dts: add more devices for zx296718
Message-ID: <1490086381-17030-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds devices mmc, vou hdmi and tvenc for zx296718 SoC and enables
those available on board zx296718-evb.

Jun Nie (1):
  arm64: dts: zte: add mmc devices for zx296718

Shawn Guo (2):
  arm64: dts: zte: add vou and hdmi devices for zx296718
  arm64: dts: zte: add tvenc device for zx296718

 arch/arm64/boot/dts/zte/zx296718-evb.dts |  28 ++++++++
 arch/arm64/boot/dts/zte/zx296718.dtsi    | 119 +++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

-- 
1.9.1
