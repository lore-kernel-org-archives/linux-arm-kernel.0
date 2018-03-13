From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 13 Mar 2018 09:39:06 +0800
Subject: [GIT PULL] i.MX new clock additions for 4.17
Message-ID: <20180313013905.GF26859@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen, Mike,

This pull request includes a few new clock additions for i.MX7D clock
driver.  Please consider to pull it for 4.17.  As I have a DT branch
built on top of this pull request to resolve the dependency on these new
clock IDs, please keep the tag stable.  Thanks.

Shawn


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/clk-imx-4.17-newid

for you to fetch changes up to 1691cc375a39d13a70829cabdd87ca9116a16907:

  clk: imx: imx7d: add the Keypad Port module clock (2018-02-28 14:43:00 +0800)

----------------------------------------------------------------
i.MX new clock additions for 4.17:
 - New clocks for i.MX7D SNVS, CAAM and Keypad.

----------------------------------------------------------------
Anson Huang (1):
      clk: imx: imx7d: add the snvs clock

Rui Miguel Silva (1):
      clk: imx7d: add CAAM clock

Stefan Agner (1):
      clk: imx: imx7d: add the Keypad Port module clock

 drivers/clk/imx/clk-imx7d.c             | 3 +++
 include/dt-bindings/clock/imx7d-clock.h | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)
