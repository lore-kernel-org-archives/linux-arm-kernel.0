From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 23 May 2018 11:17:02 -0700
Subject: [GIT PULL] Amlogic 32-bit DT updates for v4.18, round 2
Message-ID: <7h1se2s0dd.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 35ee52bea66c74a7c33cebda8692d61b1ed7c6e9:

  ARM: dts: meson8m2: add support for the Tronsmart MXIII Plus (2018-05-10 17:03:28 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt-2

for you to fetch changes up to ae0257da5701b6e44eba9dc4ebab867b56d6ea29:

  ARM: meson: merge Kconfig symbol MACH_MESON8B into MACH_MESON8 (2018-05-23 10:08:13 -0700)

----------------------------------------------------------------
Amlogic 32-bit DT changes for v4.18, round 2
- remove MACH_MESON8B, only used for building DTs

----------------------------------------------------------------
Martin Blumenstingl (2):
      ARM: dts: meson: build the Meson8b .dtbs with MACH_MESON8
      ARM: meson: merge Kconfig symbol MACH_MESON8B into MACH_MESON8

 arch/arm/boot/dts/Makefile  | 5 ++---
 arch/arm/mach-meson/Kconfig | 9 +--------
 2 files changed, 3 insertions(+), 11 deletions(-)
