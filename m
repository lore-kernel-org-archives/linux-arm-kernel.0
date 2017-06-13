From: eric@anholt.net (Eric Anholt)
Date: Tue, 13 Jun 2017 10:43:56 -0700
Subject: [GIT PULL 4/4] bcm2835-dt-64-next-2017-06-08
In-Reply-To: <20170613174356.22426-1-eric@anholt.net>
References: <20170613174356.22426-1-eric@anholt.net>
Message-ID: <20170613174356.22426-4-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

Here's the last pull request in this series.  I've based this summary
on the bcm2835-dt-next tag, to clarify what's in this patch series,
but it does require being careful since it involves a cross-merge
between branches.

The following changes since commit a19adf8d86e822eba502486524127595372c85f6:

  ARM: dts: bcm283x: switch from &sdhci to &sdhost (2017-05-16 14:38:41 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-64-next-2017-06-08

for you to fetch changes up to 4ae6f954b96c1fea86c6f21ae8fc413f5fc3444e:

  ARM64: dts: bcm2837: Define CPU thermal coefficients (2017-06-08 12:35:45 -0700)

----------------------------------------------------------------
This pull request brings in the switch to sdhost for MMC on RPi3
(improving storage performance and leaving sdhci for wireless), and
the correct CPU thermal coefficients.

The thermal changes required a merge from bcm2835-dt-next, where the
nodes were added.

----------------------------------------------------------------
Eric Anholt (1):
      Merge tag 'bcm2835-dt-next-2017-06-08' into bcm2835-dt-64-next

Gerd Hoffmann (1):
      arm64: dts: bcm2837: add &sdhci and &sdhost

Stefan Wahren (1):
      ARM64: dts: bcm2837: Define CPU thermal coefficients

 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi        |  4 ++++
 2 files changed, 21 insertions(+)
