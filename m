From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 23 Mar 2017 16:21:05 +0530
Subject: [GIT PULL 2/3] DaVinci DT updates for v4.12
In-Reply-To: <20170323105106.20144-1-nsekhar@ti.com>
References: <20170323105106.20144-1-nsekhar@ti.com>
Message-ID: <20170323105106.20144-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.12/dt

for you to fetch changes up to f8914131f7da23ab604efd8d1b95a416e5d8fc44:

  ARM: dts: da850-evm: add the output port to the vpif node (2017-03-07 16:46:56 +0530)

----------------------------------------------------------------
DaVinci device tree updates to enable
Video display on DA850 along with some
whitespace clean-up.

Also, enables sound and ADC support on
Lego EV3.

----------------------------------------------------------------
Bartosz Golaszewski (4):
      ARM: dts: da850-evm: fix whitespace errors
      ARM: dts: da850: add vpif video display pins
      ARM: dts: da850-evm: add IO expander node on UI card
      ARM: dts: da850-evm: add the output port to the vpif node

David Lechner (2):
      ARM: da850-lego-ev3: Add device tree node for A/DC
      ARM: da850-lego-ev3: Add device tree node for sound

 arch/arm/boot/dts/da850-evm.dts      | 31 ++++++++++++++-------
 arch/arm/boot/dts/da850-lego-ev3.dts | 52 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi         | 25 ++++++++++++++---
 3 files changed, 95 insertions(+), 13 deletions(-)
