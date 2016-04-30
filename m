From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 30 Apr 2016 18:52:13 +0200
Subject: [GIT PULL v2] ARM: mvebu: defconfig for v4.7 (#2)
Message-ID: <87r3dnqbsy.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second version of the second pull request for defconfig
for mvebu for v4.7! In the previous version I applied the wrong
patch. I apology for the disturbance!

Gregory

The following changes since commit 23d2af622de748bf57d31a4125d06d183c29e908:

  ARM: mvebu_v5_defconfig: Switching to the new Marvell's cryptographic engine driver (2016-04-14 18:57:19 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-4.7-2

for you to fetch changes up to 9cdea854ba58de132b1e240bd0bf515ea086297d:

  arm64: configs: add options useful for Armada 7K/8K support (2016-04-30 18:44:37 +0200)

----------------------------------------------------------------
mvebu defconfig for 4.7 (part 2)

- update arm64 defconfig with options useful for Armada 7K/8K support

----------------------------------------------------------------
Thomas Petazzoni (1):
      arm64: configs: add options useful for Armada 7K/8K support

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)
