From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 17 Dec 2014 11:02:22 +0100
Subject: [PATCH 0/2] Enable DRM/KMS support for STiH407 Family boards
Message-ID: <1418810544-11405-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set Enable DRM/KMS support for STiH407 Family boards.

Gabriel Fernandez (2):
  ARM: DT: STiH407: Add DRM dt nodes
  ARM: DT: STiH407: Specify default clocks for HDMI devices

 arch/arm/boot/dts/stih407-family.dtsi | 139 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stihxxx-b2120.dtsi  |   2 +-
 2 files changed, 140 insertions(+), 1 deletion(-)

-- 
1.9.1
