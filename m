From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  5 Jun 2012 11:30:28 +0200
Subject: i.MX IPU preparation patches
Message-ID: <1338888630-25930-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following are two patches I have which reset the IPU and setup
the MIPI interface on i.MX51. They will be needed once we add graphics
support on i.MX5, but won't harm if we add them now.

----------------------------------------------------------------
Sascha Hauer (2):
      ARM i.MX51: setup mipi
      ARM i.MX5: Hard reset the IPU during startup

 arch/arm/mach-imx/mm-imx5.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
