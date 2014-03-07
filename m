From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  6 Mar 2014 19:44:10 -0700
Subject: [GIT PULL 2/2] ARM: bcm2835: DT changes for 3.15
In-Reply-To: <1394160250-3939-1-git-send-email-swarren@wwwdotorg.org>
References: <1394160250-3939-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1394160250-3939-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A variety of features are added to the bcm2835 device trees:
- ARM PMU, for perf_event
- DMA controller
- I2S controller

A few cleanups are applied to the DTs too.

----------------------------------------------------------------

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git bcm2835-for-3.15-dt

for you to fetch changes up to b7c6c1760685f7d3a3eecc19f4b792881bf1d907:

  ARM: bcm2835: fix clock DT node names

----------------------------------------------------------------

Florian Meier (2):
      ARM: bcm2835: add dmaengine driver to device tree
      ARM: bcm2835: add I2S driver to device tree

Stephen Warren (3):
      ARM: bcm2835: fix DT node sort order
      ARM: bcm2835: node name unit address cleanup
      ARM: bcm2835: fix clock DT node names

Vince Weaver (1):
      ARM: bcm2835: perf_event support for Raspberry-Pi

 arch/arm/boot/dts/bcm2835.dtsi | 92 ++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 27 deletions(-)
