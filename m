From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Jun 2013 10:37:18 -0600
Subject: [GIT PULL 5/5] ARM: tegra: defconfig updates
In-Reply-To: <1371227838-18764-1-git-send-email-swarren@wwwdotorg.org>
References: <1371227838-18764-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1371227838-18764-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable some new features:
* The Tegra114 SPI controller, for Dalmore's SPI flash.
* Set all the GPIO leds triggers to their "if you don't know, say X"
  value, so there are some useful triggers for the gpio-leds support.
* TPS65090 charger, for Dalmore.
* ASoC RT5640 machine driver, for audio on Beaver and Dalmore.

Also, rebuild tegra_defconfig on top of linux-next. This should make it
easier to create future defconfig patches, without extraneous diffs.

This branch is based on v3.10-rc3, in order not to conflict with a
defconfig change first included there.

----------------------------------------------------------------

The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.11-defconfig

for you to fetch changes up to 16a4b5ae32cf31e64b481ab3e2aa0ae964872123:

  ARM: tegra: defconfig updates

----------------------------------------------------------------

Stephen Warren (1):
      ARM: tegra: defconfig updates

 arch/arm/configs/tegra_defconfig | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)
