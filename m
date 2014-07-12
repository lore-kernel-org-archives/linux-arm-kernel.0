From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 12 Jul 2014 15:53:15 +0200
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC CPUFreq Updates for
 v3.17
Message-ID: <cover.1405172884.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC CPUFreq
updates for v3.17.

This pull request is based on the previous round of
such requests, tagged as renesas-cpufreq-for-v3.17,
which I have already sent a pull-request for.


The following changes since commit 06e32c91dbce3c24ccbe84e3af2a35199662bca0:

  ARM: shmobile: add cpufreq-cpu0 driver for common SH-Mobile (2014-06-16 19:50:54 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-cpufreq2-for-v3.17

for you to fetch changes up to e423d12cbcb9576785e891617888f627f1f57bf4:

  ARM: shmobile: Remove opps table check for cpufreq (2014-07-09 10:48:58 +0200)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC CPUFreq Updates for v3.17

* Remove opps table check for cpufreq as this is already handled
  by the driver

----------------------------------------------------------------
Gaku Inami (1):
      ARM: shmobile: Remove opps table check for cpufreq

 arch/arm/mach-shmobile/cpufreq.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)
