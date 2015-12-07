From: stefan@agner.ch (Stefan Agner)
Date: Mon,  7 Dec 2015 13:51:12 -0800
Subject: [PATCH v2 0/4] ARM: dts: vf610: relicense the device trees under
 GPLv2/X11
Message-ID: <1449525076-23569-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I collected the Acks I received so far and removed them from the list
below. Several Freescale addresses are no longer valid (the once
starting with --)... I would interprete the Ack from Yuan Yao as an
Ack from Freescale.

Matt, you introduced the vf610-cosmic.dts board, is it possible to
get an ack for this too? I think you did not receive v1 of this patch
due to an old email address, sorry about that.

vf???.dtsi:
  --Chao Fu <B44548@freescale.com>
  Cosmin Stoica <cosminstefan.stoica@freescale.com>
  Frank Li <Frank.Li@freescale.com>
  --Fugang Duan <B38611@freescale.com>
  --Huang Shijie <b32955@freescale.com>
  --Jingchang Lu <jingchang.lu@freescale.com>
  --Xiubo Li <Li.Xiubo@freescale.com>

vf610-colibri:
  <all done>

vf610-cosmic:
  Matt Porter <mporter@kernel.crashing.org>

vf610-twr:
  --Chao Fu <B44548@freescale.com>
  Cosmin Stoica <cosminstefan.stoica@freescale.com>
  --Fugang Duan <B38611@freescale.com>
  --Jingchang Lu <b35083@freescale.com>
  --Xiubo Li <Li.Xiubo@freescale.com>

CC: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
CC: Bill Pringlemeir <bpringle@sympatico.ca>
--CC: Chao Fu <B44548@freescale.com>
CC: Cory Tusar <cory.tusar@pid1solutions.com>
CC: Cosmin Stoica <cosminstefan.stoica@freescale.com>
CC: Frank Li <Frank.Li@freescale.com>
--CC: Fugang Duan <B38611@freescale.com>
--CC: Huang Shijie <b32955@freescale.com>
--CC: Jingchang Lu <jingchang.lu@freescale.com>
CC: Lucas Stach <l.stach@pengutronix.de>
CC: Matt Porter <mporter@kernel.crashing.org>
CC: Olof Johansson <olof@lixom.net>
CC: Sanchayan Maity <maitysanchayan@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Stephen Warren <swarren@wwwdotorg.org>
--CC: Xiubo Li <Li.Xiubo@freescale.com>
CC: Yuan Yao <yao.yuan@freescale.com>

Stefan Agner (4):
  ARM: dts: vf610: relicense vf???.dtsi under GPLv2/X11
  ARM: dts: vf610-colibri: relicense vf*colibri* under GPLv2/X11
  ARM: dts: vf610-cosmic: relicense vf610-cosmic.dts under GPLv2/X11
  ARM: dts: vf610-twr: relicense vf610-twr.dts under GPLv2/X11

 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi   | 40 ++++++++++++++++++++++++---
 arch/arm/boot/dts/vf-colibri.dtsi           | 40 ++++++++++++++++++++++++---
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts | 40 ++++++++++++++++++++++++---
 arch/arm/boot/dts/vf500-colibri.dtsi        | 40 ++++++++++++++++++++++++---
 arch/arm/boot/dts/vf500.dtsi                | 40 ++++++++++++++++++++++++---
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts | 42 +++++++++++++++++++++++++----
 arch/arm/boot/dts/vf610-colibri.dtsi        | 40 ++++++++++++++++++++++++---
 arch/arm/boot/dts/vf610-cosmic.dts          | 40 ++++++++++++++++++++++++---
 arch/arm/boot/dts/vf610-twr.dts             | 40 ++++++++++++++++++++++++---
 arch/arm/boot/dts/vf610.dtsi                | 40 ++++++++++++++++++++++++---
 arch/arm/boot/dts/vfxxx.dtsi                | 40 ++++++++++++++++++++++++---
 11 files changed, 397 insertions(+), 45 deletions(-)

-- 
2.6.3
