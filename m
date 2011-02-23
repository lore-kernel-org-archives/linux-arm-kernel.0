From: ccross@android.com (Colin Cross)
Date: Wed, 23 Feb 2011 13:31:30 -0800
Subject: [GIT PULL] Please pull tegra board updates for .39
In-Reply-To: <AANLkTim99BSkaX-hm8kb43tm6YJY5VUk6OYL6SwyPmD5@mail.gmail.com>
References: <AANLkTimA1=CCXM8wmkoatL59mzitC=5-GK3HUs-_daE9@mail.gmail.com>
	<AANLkTim99BSkaX-hm8kb43tm6YJY5VUk6OYL6SwyPmD5@mail.gmail.com>
Message-ID: <AANLkTi=5MN6mjQKZz-HEb91c+7yEv5QSviSg-cpPUNQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 1:17 PM, Olof Johansson <olof@lixom.net> wrote:
> Colin,
>
> Since things got held up due to rebases and a few patch respins,
> here's a fresh pull request and diff stats. Please pull
> boards-for-next.
>
> Given current activity, I expect to stage one more pull before the
> merge window once the i2c driver is in the main tegra for-next branch.
>
>
>
> The following changes since commit 38376866a1fe5b1e6d9510ec4913c2b461f456f3:
> ?Mark Brown (1):
> ? ? ? ?ARM: tegra: Hide EMC scaling config behind ARCH_TEGRA
>
> are available in the git repository at:
>
> ?git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra-2.6.git
> boards-for-next
>
> Olof Johansson (7):
> ? ? ?ARM: tegra: add tegra_gpio_table and tegra_gpio_config
> ? ? ?ARM: tegra: harmony: move over to tegra_gpio_config
> ? ? ?ARM: tegra: common device resources
> ? ? ?ARM: tegra: remove stale nvidia atag handler
> ? ? ?ARM: tegra: harmony: register sdhci devices
> ? ? ?ARM: tegra: harmony: fix pinmux for MMC slot
> ? ? ?ARM: tegra: add seaboard, wario and kaen boards
>
> ?arch/arm/mach-tegra/Kconfig ? ? ? ? ? ? ? ? | ? 19 +
> ?arch/arm/mach-tegra/Makefile ? ? ? ? ? ? ? ?| ? ?4 +
> ?arch/arm/mach-tegra/board-harmony-pinmux.c ?| ? 19 +-
> ?arch/arm/mach-tegra/board-harmony.c ? ? ? ? | ? 55 ++--
> ?arch/arm/mach-tegra/board-seaboard-pinmux.c | ?179 ++++++++++
> ?arch/arm/mach-tegra/board-seaboard.c ? ? ? ?| ?196 +++++++++++
> ?arch/arm/mach-tegra/board-seaboard.h ? ? ? ?| ? 38 ++
> ?arch/arm/mach-tegra/devices.c ? ? ? ? ? ? ? | ?505 +++++++++++++++++++++++++++
> ?arch/arm/mach-tegra/devices.h ? ? ? ? ? ? ? | ? 46 +++
> ?arch/arm/mach-tegra/gpio.c ? ? ? ? ? ? ? ? ?| ? 14 +
> ?arch/arm/mach-tegra/include/mach/gpio.h ? ? | ? ?7 +
> ?11 files changed, 1054 insertions(+), 28 deletions(-)
> ?create mode 100644 arch/arm/mach-tegra/board-seaboard-pinmux.c
> ?create mode 100644 arch/arm/mach-tegra/board-seaboard.c
> ?create mode 100644 arch/arm/mach-tegra/board-seaboard.h
> ?create mode 100644 arch/arm/mach-tegra/devices.c
> ?create mode 100644 arch/arm/mach-tegra/devices.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>

Thanks, merged to tegra/for-next
