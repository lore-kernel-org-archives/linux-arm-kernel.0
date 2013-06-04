From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue,  4 Jun 2013 11:12:26 +0200
Subject: [PATCH 0/4] updates for tqma53.dtsi
Message-ID: <1370337150-18487-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This series consists of misc updates for the tqma53.dtsi.
It is rebased to Shawns for-next branch.

Regards,
Steffen

Philipp Zabel (2):
  ARM i.MX53: tqma53: fix pinctrl settings
  ARM i.MX53: tqma53: rev 300 specific pin configuration

Sascha Hauer (1):
  ARM i.MX53: tqma53: Fix interrupt polarity for the mc34708

Steffen Trumtrar (1):
  ARM i.MX53: tqma53: add WP/CD pinctrl and vmmc to esdhc2

 arch/arm/boot/dts/imx53-tqma53.dtsi | 45 +++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 17 deletions(-)

-- 
1.8.2.rc2
