From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 15 Mar 2013 16:38:58 +0000
Subject: [PATCH 0/2] Versatile Express fixes
Message-ID: <1363365540-23001-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

These are two fixes for small problems with VE that has been brought
to my attention recently. It would be great to get them pulled into
one of the 3.9-rcX, but as they are not really critical they could
wait till 3.10 if you feel it's the best thing to do.

Thanks!

Pawel

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2 (2013-03-10 16:54:19 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git tags/vexpress/fixes-for-3.9-rc3

for you to fetch changes up to f5107e0e2e9d4f16fd7ebae8059b17faa6f8abd1:

  ARM: vexpress: Remove A9 compatible value for V2P-CA5s PMU node (2013-03-15 16:12:11 +0000)

----------------------------------------------------------------
Versatile Express related fixes for 3.9-rc3
* Fix PMU node in vexpress-v2p-ca5s.dts
* Enforce required regulator framework when MMCI driver is enabled

----------------------------------------------------------------
Pawel Moll (2):
      ARM: vexpress: Enable regulator framework when MMCI is in use
      ARM: vexpress: Remove A9 compatible value for V2P-CA5s PMU node

 arch/arm/boot/dts/vexpress-v2p-ca5s.dts |    2 +-
 arch/arm/mach-vexpress/Kconfig          |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
