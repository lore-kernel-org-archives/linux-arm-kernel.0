From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 12:49:04 +0900
Subject: [GIT PULL] Renesas ARM-based SoC for v3.9 #5
Message-ID: <1361245745-23355-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit dbe1c3defb3844772634446492ea6c13882596ec:

  ARM: shmobile: Register ARM architected timer (2013-02-05 17:13:55 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc5-for-v3.9

for you to fetch changes up to f9047306fd7332d682898dd689152bb3b45a3e73:

  ARM: shmobile: r8a7779: Correct TMU clock support again (2013-02-19 10:05:27 +0900)

----------------------------------------------------------------
This resolves a panic-on-boot regression introduced by me when incorrectly
updating TMU clock definitions.

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: r8a7779: Correct TMU clock support again

 arch/arm/mach-shmobile/clock-r8a7779.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
