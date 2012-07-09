From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 9 Jul 2012 16:10:21 +0530
Subject: [GIT PULL] DaVinci fixes for v3.6
Message-ID: <4FFAB515.1070708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following DaVinci fix for v3.6

Thanks,
Sekhar

The following changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71:

  Linux 3.5-rc3 (2012-06-16 17:25:17 -0700)

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git tags/davinci-v3.6-fixes

for you to fetch changes up to bbb33445b9cdd5ac7609723fcfc28dfa77a11039:

  ARM: davinci: da8xx: fix interrupt handling (2012-07-09 16:01:11 +0530)

----------------------------------------------------------------
DaVinci fixes for v3.6

Fix an interrupt handling issue with cp_intc which
was causing occasional spurious interrupts with DA850 EVM

----------------------------------------------------------------
Sekhar Nori (1):
      ARM: davinci: da8xx: fix interrupt handling

 arch/arm/mach-davinci/include/mach/entry-macro.S |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)
