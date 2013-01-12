From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 12 Jan 2013 17:36:26 +1300
Subject: [GIT PULL] clk: vt8500: Clock fixes for 3.8
Message-ID: <1357965386.18190.1.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,


The following changes since commit
a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://server.prisktech.co.nz/git/linuxwmt.git tags/clk-fixes-3.8

for you to fetch changes up to a3c2b58889440dcc6de92d04f09e8fcaf6bf7e2e:

  clk: vt8500: Fix division-by-0 when requested rate=0 (2012-12-27
13:07:23 +1300)

----------------------------------------------------------------
clk: vt8500: Clock fixes for v3.8

Small series of fixes for clocks on vt8500.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

----------------------------------------------------------------
Tony Prisk (3):
      clk: vt8500: Fix error in PLL calculations on non-exact match.
      clk: vt8500: Fix device clock divisor calculations
      clk: vt8500: Fix division-by-0 when requested rate=0

 drivers/clk/clk-vt8500.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)
