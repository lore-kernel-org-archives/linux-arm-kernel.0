From: patrice.chotard@st.com (Patrice Chotard)
Date: Fri, 1 Jul 2016 15:28:58 +0200
Subject: [GIT PULL] STi DT updates for v4.8
Message-ID: <5776701A.1000808@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi DT updates for v4.8:

The following changes since commit 6ca59e6e1fc3a8d7ccbf85ff036bd6ff40847c1a:

   clk: st: clkgen-pll: Detect critical clocks (2016-06-30 12:17:11 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 
sti-dt-for-v4.8

for you to fetch changes up to 4543976eaf9ca9f379ac3a0bb8c5c8c84fe0a965:

   spi: st-ssc4: Remove 'no clocking' hack (2016-07-01 11:58:10 +0200)

----------------------------------------------------------------
Highlights:
-----------
  -add STi critical clocks
- as discussed on IRC with Lee Jones, remove SPI hack wich has dependecy 
with critical clocks

----------------------------------------------------------------
Lee Jones (3):
       ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
       ARM: sti: stih410-clocks: Identify critical clocks
       spi: st-ssc4: Remove 'no clocking' hack

  arch/arm/boot/dts/stih410-clock.dtsi     |  9 ++++++++
  drivers/spi/spi-st-ssc4.c                | 36 
+++++---------------------------
  include/dt-bindings/clock/stih407-clks.h |  4 ++++
  3 files changed, 18 insertions(+), 31 deletions(-)
