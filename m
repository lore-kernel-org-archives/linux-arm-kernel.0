From: panetta.mike@gmail.com (Michael Panetta)
Date: Wed, 31 Jul 2013 17:40:46 -0400
Subject: [PATCH] ARM: dts: imx6qdl-wandboard: add gpio lines to wandboard
 shared dtsi.
Message-ID: <1375306847-14340-1-git-send-email-panetta.mike@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to the wandboard shared dts file for the 10 GPIO lines that are exposed on the EDM connector.

Michael Panetta (1):
  Add dts info for wandboard GPIO lines.

 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
1.7.11.7
