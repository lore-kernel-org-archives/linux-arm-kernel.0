From: ccross@google.com (Colin Cross)
Date: Wed, 26 Jan 2011 21:41:40 -0800
Subject: [GIT PULL] ARM Tegra fixes for 2.6.38
Message-ID: <AANLkTim6zcdn8FgUTa7OO=_4B3x5CiHxWr_g=uR0m4zX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
Please pull fixes for the Tegra machine from:

  http://android.git.kernel.org/kernel/tegra.git for-linus

Thanks,
Colin

The following changes since commit 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:

  Linux 2.6.38-rc2 (2011-01-21 19:01:34 -0800)

are available in the git repository at:
  http://android.git.kernel.org/kernel/tegra.git for-linus

Colin Cross (2):
      ARM: tegra: irq: Rename gic pointers to avoid conflicts
      ARM: tegra: clock: Add forward reference to struct clk

Grant Likely (1):
      arm/tegra: Fix tegra irq_data conversion

 arch/arm/mach-tegra/gpio.c                |    4 ++--
 arch/arm/mach-tegra/include/mach/clk.h    |    2 ++
 arch/arm/mach-tegra/include/mach/clkdev.h |    2 ++
 arch/arm/mach-tegra/irq.c                 |   18 +++++++++---------
 4 files changed, 15 insertions(+), 11 deletions(-)
