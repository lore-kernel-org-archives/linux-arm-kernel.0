From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 10 May 2016 16:44:42 +0200
Subject: [GIT PULL] ARM: mvebu: defconfig64 for v4.7 (#1)
Message-ID: <87twi6nfad.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for defconfig64 for mvebu for v4.7.

Gregory

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig64-4.7-1

for you to fetch changes up to e5d8b0ad5ae4c70a7081865a3c6c83ae1afe3087:

  arm64: configs: add options useful for Armada 7K/8K support (2016-05-10 14:42:23 +0200)

----------------------------------------------------------------
mvebu defconfig for arm64 for 4.7

- update arm64 defconfig with options useful for Armada 7K/8K support

----------------------------------------------------------------
Thomas Petazzoni (1):
      arm64: configs: add options useful for Armada 7K/8K support

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)
