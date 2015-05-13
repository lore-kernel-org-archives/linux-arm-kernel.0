From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 13 May 2015 15:49:33 +0200
Subject: [GIT PULL 1/8] ARM: tegra: Cleanup patches for v4.2-rc1
In-Reply-To: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1431524980-13599-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.2-cleanup

for you to fetch changes up to 85aa5047e369d963b88af3e817dd40e692175153:

  ARM: tegra: Fix typo (reset -> rest) in comment (2015-05-04 13:25:19 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Cleanup patches for v4.2-rc1

Just a couple of trivial cleanups such as a typofix and conversion of
hexadecimal numbers to all lower-case in DTS files for consistency.

----------------------------------------------------------------
Thierry Reding (2):
      ARM: tegra: Use lower-case hexadecimal digits
      ARM: tegra: Fix typo (reset -> rest) in comment

 Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt | 2 +-
 arch/arm/boot/dts/tegra124.dtsi                                | 2 +-
 arch/arm/boot/dts/tegra20.dtsi                                 | 2 +-
 arch/arm/mach-tegra/sleep-tegra30.S                            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
