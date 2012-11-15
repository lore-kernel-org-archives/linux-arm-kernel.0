From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 15 Nov 2012 12:07:27 -0800
Subject: common clk fixes for 3.7-rc6, part 2
Message-ID: <20121115200727.7155.72698@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://git.linaro.org/people/mturquette/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 93532c8a4890871aa0d84dd91b80dad9f58542e0:

  clk: remove inline usage from clk-provider.h (2012-11-15 11:38:34 -0800)

----------------------------------------------------------------
GCC 4.7 users get compilation errors from unnecessary use of inline in
clk-provider.h.  This pull request fixes the regression by removing inline
usage from those function declarations.

----------------------------------------------------------------
Igor Mazanov (1):
      clk: remove inline usage from clk-provider.h

 include/linux/clk-provider.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
