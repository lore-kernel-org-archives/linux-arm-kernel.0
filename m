From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 28 Apr 2011 22:14:33 +0800
Subject: [GIT PULL] pxa: fix for v2.6.39-rc4
Message-ID: <BANLkTimQ3mZS8pi_4MajhWbZ=QqqKiFdWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f0e615c3cb72b42191b558c130409335812621d8:

  Linux 2.6.39-rc4 (2011-04-18 21:26:00 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Ben Hutchings (1):
      ARM: Fix .size directive for xscale_dma_a0_map_area

Paul Parsons (1):
      ARM: pxa/hx4700: bq24022 regulator needs to be enabled

Philipp Zabel (1):
      ARM: pxa/magician: bq24022 regulator needs to be enabled

 arch/arm/mach-pxa/hx4700.c   |    2 +-
 arch/arm/mach-pxa/magician.c |    2 +-
 arch/arm/mm/proc-xscale.S    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
