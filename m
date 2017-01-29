From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 29 Jan 2017 22:06:28 +0200
Subject: [GIT PULL 3/4] ARM: dts: exynos: for v4.11, 2nd round
In-Reply-To: <20170129200630.22083-1-krzk@kernel.org>
References: <20170129200630.22083-1-krzk@kernel.org>
Message-ID: <20170129200630.22083-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit bca9085e0ae93253bc93ce218c85ac7d7e7f1831:

  ARM: dts: exynos: remove Exynos4212 support (dead code) (2017-01-11 18:28:43 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.11-2

for you to fetch changes up to dfaf06baad0c088a55570f7a324949c498f2106c:

  ARM: dts: exynos: Fix indentation of EHCI and OHCI ports (2017-01-29 21:03:46 +0200)

----------------------------------------------------------------
Samsung DeviceTree update for v4.11, second round:
1. Use bigger reserved memory region for Multi Format Codec on all Exynos
   chipsets so it could decode FullHD easily.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: dts: exynos: Increase MFC left reserved memory region size

Krzysztof Kozlowski (1):
      ARM: dts: exynos: Fix indentation of EHCI and OHCI ports

 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi |  2 +-
 arch/arm/boot/dts/exynos4.dtsi                    | 24 +++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)
