From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Fri, 26 Aug 2016 15:46:19 -0500
Subject: [PATCH 0/2] arm64: dts: ls1043a/ls2080a serial updates
Message-ID: <1472244381-1766-1-git-send-email-stuart.yoder@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series serial aliases for ls2080a-rdb/qds and ls1043a-rdb,
fixes the aliases in ls1043a-qds and sets stdout-path for all the
boards.

Stuart Yoder (2):
  arm64: dts: updates serial aliases for ls1043a rdb and qds boards
  arm64: dts: add stdout-path to chosen node for ls2080a/ls1043a boards

 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 14 ++++++++------
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts |  8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts |  3 +++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts |  4 ++++
 4 files changed, 23 insertions(+), 6 deletions(-)

-- 
1.9.0
