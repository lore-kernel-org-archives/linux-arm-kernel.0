From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Nov 2011 10:41:23 +0100
Subject: [GIT PULL] U300 and Ux500 defconfigs
Message-ID: <CACRpkdbNOucfZdfENJ44Q8dB73=nupt9913O+Zp4PCFUn5Ec3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

could you please pull these defconfig patches into arm-soc,
they are mainly adjusting these defconfigs for stuff merged
during the 3.2 merge window or earlier. You can push for
the -rc:s or next merge window at your choice, no big deal
for me. Both have been reviewed on the mailing list and
of course use the minimal format from saveconfig.

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:

  Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)

are available in the git repository at:
 git://git.linaro.org/people/triad/linux-stericsson.git defconfigs-for-arnd

Linus Walleij (2):
      ARM: u300: update defconfig
      ARM: ux500: update defconfig

 arch/arm/configs/u300_defconfig  |   13 ++++++-------
 arch/arm/configs/u8500_defconfig |   14 +++++---------
 2 files changed, 11 insertions(+), 16 deletions(-)
