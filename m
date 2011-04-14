From: ccross@google.com (Colin Cross)
Date: Wed, 13 Apr 2011 22:50:58 -0700
Subject: ARM Tegra fixes for 2.6.39-rc4
Message-ID: <BANLkTimtnD3OMWT11Kf4A8dyx=Vp9DOOGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
Please pull minor fixes for Tegra from:

 git://android.git.kernel.org/kernel/tegra.git for-linus

Thanks,
Colin


The following changes since commit 0ce790e7d736cedc563e1fb4e998babf5a4dbc3d:

  Linux 2.6.39-rc1 (2011-03-29 12:09:47 -0700)

are available in the git repository at:
  git://android.git.kernel.org/kernel/tegra.git for-linus

Colin Cross (1):
      ARM: tegra: gpio: Fix unused variable warnings

Nicolas Kaiser (1):
      arm: tegra: fix error check in tegra2_clocks.c

 arch/arm/mach-tegra/gpio.c          |    6 ++++--
 arch/arm/mach-tegra/tegra2_clocks.c |    9 +++++----
 2 files changed, 9 insertions(+), 6 deletions(-)
