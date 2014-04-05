From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 5 Apr 2014 20:06:32 +0100
Subject: [GIT PULL 7/8] ARM: SoC: sh driver changes
In-Reply-To: <201404052101.19381.arnd@arndb.de>
References: <201404052101.19381.arnd@arndb.de>
Message-ID: <201404052106.32628.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0414855fdc4a40da05221fc6062cccbc0c30f169:

  Linux 3.14-rc5 (2014-03-02 18:56:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/sh-3.15

for you to fetch changes up to 13ce64c8f7750ce59066a987951faff38bb7dd97:

  Merge tag 'renesas-intc-for-v3.15' of git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/sh (2014-03-16 23:30:04 -0700)

----------------------------------------------------------------

ARM: SoC: sh driver changes

The drivers/sh subdirectory used to get merged through the SH architecture
tree, but things are in flux there and some of the drivers are shared
with ARM shmobile, we have picked it up for the time being.

There is only one trivial patch from Laurent Pinchart this time.

----------------------------------------------------------------
Laurent Pinchart (1):
      sh: intc: Enable driver compilation with COMPILE_TEST

Olof Johansson (1):
      Merge tag 'renesas-intc-for-v3.15' of git://git.kernel.org/.../horms/renesas into next/sh

 drivers/sh/intc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
