From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Thu, 19 Apr 2018 05:14:35 +0900
Subject: [PATCH 0/5] arm64: dts: renesas: r8a779xx: sort nodes
Message-ID: <1524082480-18163-1-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort nodes of the R-Car M3-N (r8a77965), V3M (r8a77970) and D3 (r8a77995) DTs.

This is part of an ongoing effort to provide consistent node
order in the DT of Renesas SoCs to improve maintainability.

This should not have any run-time effect.

Based on the devel branch of Simon Horman's renesas tree.

Yoshihiro Kaneko (5):
  arm64: dts: renesas: r8a77995: sort subnodes of the root node
  arm64: dts: renesas: r8a77995: sort subnodes of the soc node
  arm64: dts: renesas: r8a77965: sort subnodes of the root node
  arm64: dts: renesas: r8a77965: sort subnodes of the soc node
  arm64: dts: renesas: r8a77970: sort subnodes of the soc node

 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 1160 ++++++++++++++---------------
 arch/arm64/boot/dts/renesas/r8a77970.dtsi |  378 +++++-----
 arch/arm64/boot/dts/renesas/r8a77995.dtsi |  717 +++++++++---------
 3 files changed, 1127 insertions(+), 1128 deletions(-)

-- 
1.9.1
