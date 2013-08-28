From: alison_chaiken@mentor.com (alison_chaiken at mentor.com)
Date: Tue, 27 Aug 2013 20:17:33 -0700
Subject: [PATCH 0/2] 
In-Reply-To: <521C40D9.3070802@freescale.com>
References: <521C40D9.3070802@freescale.com>
Message-ID: <1377659855-9573-1-git-send-email-alison_chaiken@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alison Chaiken <alison_chaiken@mentor.com>

Tested on a variety of i.MX6 reference boards with older kernels.    Newly added
pinctrl configuration settings that are not tested are not modified.

Changes since v1:
 * Now rebased on linux-next.

Alison Chaiken (2):
  ARM: i.MX6: dts: change iomuxc pinctrl config to match Rev. 1 IMX6DQRM
  i.MX6: Documentation: Change fsl,imx-pinctrl.txt to match i.MX6 TRM

 .../bindings/pinctrl/fsl,imx-pinctrl.txt           |  25 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     | 354 ++++++++++-----------
 arch/arm/boot/dts/imx6sl.dtsi                      |  48 +--
 3 files changed, 214 insertions(+), 213 deletions(-)

-- 
1.8.4
