From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 14:34:25 +0100
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v4.10
Message-ID: <cover.1479387356.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC updates for v4.10.

This pull request is based on the previous round of
such requests, tagged as renesas-soc-for-v4.10,
which I have already sent a pull-request for.


The following changes since commit 9652623f8f019edc93a7a934a10b7d0b90421d5a:

  ARM: shmobile: r8a7779/marzen: Add board part number to DT bindings (2016-11-04 10:25:45 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v4.10

for you to fetch changes up to 4af239175d00c1866cc6b41f3eabcf93c45dcc40:

  ARM: shmobile: document SK-RZG1E board (2016-11-15 10:59:35 +0100)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Updates for v4.10

* Basic support for r8a7745 SoC

----------------------------------------------------------------
Sergei Shtylyov (2):
      ARM: shmobile: r8a7745: basic SoC support
      ARM: shmobile: document SK-RZG1E board

 Documentation/devicetree/bindings/arm/shmobile.txt | 4 ++++
 arch/arm/mach-shmobile/Kconfig                     | 4 ++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c           | 1 +
 3 files changed, 9 insertions(+)
