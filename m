From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri,  9 Oct 2015 20:48:12 +0200
Subject: [GIT PULL 1/3] ARM: berlin: CPU clock topic for v4.4 (round 1)
Message-ID: <1444416494-3117-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is a branch adding cpu clock to the BG2Q driver while also
moving some #define to the dt-binding. As the Berlin DT PR will
require this, I have chosen to make this topic branch a
prerequisite for the DT PR. The clk driver patches have appropriate
Acked-by's from clk maintainers.

Please pull.

Sebastian

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-cpuclk-for-4.4-1

for you to fetch changes up to 44b2e5f96d5e8be80c4a8c09492ddae6f98afc2a:

  clk: berlin: add cpuclk (2015-09-23 22:53:01 +0200)

----------------------------------------------------------------
Marvell Berlin CPU clk topic branch:
- move MAX_CLKS to dt-binding includes
- add BG2Q CPU clock driver

This is a topic branch for cpufreq nodes added
in berlin/dt

----------------------------------------------------------------
Antoine Tenart (2):
      clk: berlin: move MAX_CLKS out of drivers/clk/berlin
      clk: berlin: add cpuclk

 drivers/clk/berlin/bg2.c             |  1 -
 drivers/clk/berlin/bg2q.c            | 13 ++++++-------
 include/dt-bindings/clock/berlin2.h  |  2 ++
 include/dt-bindings/clock/berlin2q.h |  3 +++
 4 files changed, 11 insertions(+), 8 deletions(-)
