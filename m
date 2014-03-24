From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Mon, 24 Mar 2014 10:22:13 +0800
Subject: [PATCHv2 0/3] Add DTS node for FTM PWM
Message-ID: <1395627736-5338-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:
- Fix the issues pointed by Shawn.



Xiubo Li (3):
  ARM: dts: vf610: Add Freescale FTM PWM node. ==> resend v10
  ARM: dts: vf610-twr: Add PWM0's pinctrl node ==> new
  ARM: dts: vf610-twr: Enables FTM PWM device. ==> resend v10

 arch/arm/boot/dts/vf610-twr.dts | 17 +++++++++++++++++
 arch/arm/boot/dts/vf610.dtsi    | 13 +++++++++++++
 2 files changed, 30 insertions(+)

-- 
1.8.4
