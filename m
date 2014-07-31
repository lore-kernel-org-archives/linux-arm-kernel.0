From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jul 2014 09:33:02 +0900
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC Clock Updates for
 v3.17
Message-ID: <cover.1406766463.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these fourth round of Renesas ARM based SoC clock
updates for v3.17.

I am sending this even though v3.16-rc6 has long since been released
as this pull-request only includes a single one line fix for a problem
introduced in patches you have already queued up for v3.16.

At it turns out the problem should not manifest at run time
as it is an error in an clock that is not used without DT modifications.
As such I am happy for you to ask me to defer this to v3.18 if you like.

This pull request is based on the previous round of
such requests, tagged as renesas-clock3-for-v3.17,
which you have already merged.


The following changes since commit a0f7e7496d56ac2da7c684e2035815318c17973a:

  ARM: shmobile: sh73a0: add CMT1 clock support for DT (2014-07-15 13:34:17 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock4-for-v3.17

for you to fetch changes up to 2c3758b01aa6f11382d2b018614b5d48ecf30350:

  ARM: shmobile: sh73a0: Remove spurious 0x from SCIFB clock name (2014-07-16 23:09:18 +0900)

----------------------------------------------------------------
Fourth Round of Renesas ARM Based SoC Clock Updates for v3.17

* Remove spurious 0x from SCIFB clock name

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: sh73a0: Remove spurious 0x from SCIFB clock name

 arch/arm/mach-shmobile/clock-sh73a0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
