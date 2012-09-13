From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 13 Sep 2012 10:35:36 +0200
Subject: [GIT PULL 4/5] ARM: i.MX: Fix SSI clock associations for i.MX25/i.MX35
In-Reply-To: <1347525337-19115-1-git-send-email-s.hauer@pengutronix.de>
References: <1347525337-19115-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1347525337-19115-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-fixes

for you to fetch changes up to 48540058612786d365602f3324ed97f9071092de:

  ARM: clk-imx35: Fix SSI clock registration (2012-09-11 11:52:28 +0200)

----------------------------------------------------------------
ARM: i.MX: Fix SSI clock associations for i.MX25/i.MX35

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: clk-imx25: Fix SSI clock registration
      ARM: clk-imx35: Fix SSI clock registration

 arch/arm/mach-imx/clk-imx25.c |    6 ++----
 arch/arm/mach-imx/clk-imx35.c |    6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)
