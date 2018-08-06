From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 06 Aug 2018 12:37:13 +0200
Subject: Reset controller fixes for v4.18
Message-ID: <1533551833.4204.10.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc maintainers,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-fixes-for-4.18

for you to fetch changes up to 26fce0557fa639fb7bbc33e31a57cff7df25c3a0:

  reset: imx7: Fix always writing bits as 0 (2018-07-23 13:00:28 +0200)

----------------------------------------------------------------
Reset controller fixes for v4.18

This tag fixes reset assertion on i.MX7 for all non-inverted reset
control bits. Currently only PCIE controller and PHY resets are used.

----------------------------------------------------------------
Leonard Crestez (1):
      reset: imx7: Fix always writing bits as 0

 drivers/reset/reset-imx7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
