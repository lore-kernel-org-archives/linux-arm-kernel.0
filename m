From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 12 May 2014 22:45:00 +0800
Subject: [GIT PULL] sirf clk update for 3.16
Message-ID: <CAGsJ_4z+Y2P1YNTQWC-VsaT3N0Kasd=LvxAbLVLMftnt8gZbkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

can you pull the below update for 3.16? it cleanups the sirf clk codes
to fix some minor checkpatch issues according to key customer's
requirement.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/clk-sirf-for-3.16

for you to fetch changes up to d7ba5ba84c169e369dd3480f3968044f2f8946a8:

  clk: sirf: fix a bundle of checkpatch issues (2014-05-12 22:32:05 +0800)

----------------------------------------------------------------
clk: sirf: update for 3.16

fix minor checkpatch issues according to key customers' requirement.

----------------------------------------------------------------
Bin Shi (1):
      clk: sirf: fix a bundle of checkpatch issues

 drivers/clk/sirf/clk-atlas6.c |   12 ++++++------
 drivers/clk/sirf/clk-common.c |   22 ++++++++++++----------
 drivers/clk/sirf/clk-prima2.c |   10 +++++-----
 3 files changed, 23 insertions(+), 21 deletions(-)

-barry
