From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Mon, 24 Jul 2017 10:50:03 +0200
Subject: [PATCH 0/2] ARM: dts: sabrelite/nitrogen6x: fix USB PHY reset
Message-ID: <20170724085005.22101-1-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series is follow-up to those two patches:
https://patchwork.kernel.org/patch/9395531/
https://patchwork.kernel.org/patch/9395539/

At the time they were refused because a pwrseq library was supposed to
get in. Unfortunately that plan hasn't succeeded yet so re-submitting
the original two patches with the following modifications:
- Rebase on top of v4.13-rc2
- Reword the title to make it clear this is a fix
- Reword the changelog so it is clearly a temporary workaround

Let me know if you have any question.

Regards,
Gary

Gary Bisson (2):
  ARM: dts: imx6qdl-sabrelite: fix USB PHY reset
  ARM: dts: imx6qdl-nitrogen6x: fix USB PHY reset

 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.11.0
