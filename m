From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri,  9 Oct 2015 20:48:50 +0200
Subject: [GIT PULL 2/2] ARM64: berlin: SoC changes for v4.4 (round 1)
In-Reply-To: <1444416530-3207-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1444416530-3207-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1444416530-3207-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is Marvell Berlin ARM64 SoC changes round 1 for v4.4. There is
a single patch to add ARCH_REQUIRE_GPIOLIB to allow to use GPIO drivers.

Please pull.

Sebastian

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin64-soc-for-4.4-1

for you to fetch changes up to c582fbfba581d1331a52a85f0d712b0b7ec961c3:

  arm64: berlin: enable ARCH_REQUIRE_GPIOLIB (2015-09-20 20:32:10 +0200)

----------------------------------------------------------------
Marvell Berlin ARM64 SoC for 4.4 take 1
- enable ARCH_REQUIRE_GPIOLIB for DW GPIO driver

----------------------------------------------------------------
Jisheng Zhang (1):
      arm64: berlin: enable ARCH_REQUIRE_GPIOLIB

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)
