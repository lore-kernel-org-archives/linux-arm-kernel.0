From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 24 Jan 2017 18:36:38 +0530
Subject: [GIT PULL 1/4] TI DaVinci non-critical fixes for v4.11
Message-ID: <20170124130641.28264-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.11/fixes-non-critical

for you to fetch changes up to 430d7dd448f48f54e79614ca237f44cd543f73da:

  bus: da850-mstpri: fix my e-mail address (2017-01-02 15:52:32 +0530)

----------------------------------------------------------------
Non-critical DaVinci fixes for v4.11

* Coding style and typo fix
* Make PLL0 rate setting API for DA850
  less confusing to use.

----------------------------------------------------------------
Bartosz Golaszewski (3):
      ARM: davinci: da850: coding style fix
      ARM: davinci: da850: fix da850_set_pll0rate()
      bus: da850-mstpri: fix my e-mail address

 arch/arm/mach-davinci/da850.c     | 24 +++++++++++++++++++-----
 drivers/bus/da8xx-mstpri.c        |  2 +-
 drivers/cpufreq/davinci-cpufreq.c |  2 +-
 3 files changed, 21 insertions(+), 7 deletions(-)
