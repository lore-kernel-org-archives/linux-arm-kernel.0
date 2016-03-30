From: carlo@caione.org (Carlo Caione)
Date: Wed, 30 Mar 2016 21:56:35 +0200
Subject: [GIT PULL] gxbb: ARM64 changes for 4.7
Message-ID: <CAOQ7t2bEOM8A=6vRjXJGKof3xbtFxHj8zYCgSfOkoORy-fEGbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
simple defconfig change to enable the ARM64 Amlogic boards.

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://github.com/carlocaione/linux-meson tags/gxbb-arm64

for you to fetch changes up to 97d8eb16aa84eb48466f34c3ec0f492f34b85a04:

  arm64: defconfig: enable basic boot for Amlogic meson (2016-03-30
19:50:47 +0200)

----------------------------------------------------------------
Update defconfig to have basic boot for the Amlogic meson boards.

----------------------------------------------------------------
Kevin Hilman (1):
      arm64: defconfig: enable basic boot for Amlogic meson

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)
