From: panetta.mike@gmail.com (Michael Panetta)
Date: Tue,  6 Aug 2013 17:35:16 -0400
Subject: [Repost PATCH] ARM: dts: imx6qdl-wandboard: add gpio lines to
 wandboard shared dtsi.
Message-ID: <1375824917-9420-1-git-send-email-panetta.mike@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to the wandboard shared dts file for the 10 GPIO lines that are exposed on the EDM connector.

Michael Panetta (1):
  Add dts info for wandboard GPIO lines.

 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Signed-off-by: Mike Panetta <panetta.mike@gmail.com>
-- 
1.7.11.7
