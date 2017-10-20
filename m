From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 Oct 2017 10:41:29 +0200
Subject: [GIT PULL] Amlogic clock driver updates for 4.15
Message-ID: <f83efd53-0600-a4b4-3ee2-089e435a8cb4@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Below is a request to pull the Amlogic clock driver updates for 4.15.

Thanks,
Neil

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://github.com/baylibre/clk-meson.git tags/meson-clk-for-4.15

for you to fetch changes up to 762a1f2098b2fd4f84ccdb62d5747fff1ad7f816:

  clk: meson: gxbb: Add VPU and VAPB clocks data (2017-10-20 10:34:49 +0200)

----------------------------------------------------------------
Amlogic clock changes for 4.15

- Addition of Video Processing Unit VPU and VAPB clocks

----------------------------------------------------------------
Neil Armstrong (2):
      clk: meson: gxbb: Add VPU and VAPB clockids
      clk: meson: gxbb: Add VPU and VAPB clocks data

 drivers/clk/meson/gxbb.c              | 292 ++++++++++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.h              |   6 +-
 include/dt-bindings/clock/gxbb-clkc.h |  11 ++
 3 files changed, 308 insertions(+), 1 deletion(-)
