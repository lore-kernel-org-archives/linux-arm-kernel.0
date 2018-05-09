From: david@lechnology.com (David Lechner)
Date: Wed,  9 May 2018 10:36:40 -0500
Subject: [PATCH v3 0/2] clk: davinci: pll-dm355: fix SYSCLKn parent names
Message-ID: <20180509153642.22399-1-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3 changes:
* swap order of patches

v2 changes:
* add new patch to remove non-existent PLL2 SYSCLK2

David Lechner (2):
  clk: davinci: pll-dm355: drop pll2_sysclk2
  clk: davinci: pll-dm355: fix SYSCLKn parent names

 drivers/clk/davinci/pll-dm355.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.17.0
