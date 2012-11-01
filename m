From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  1 Nov 2012 09:43:14 -0600
Subject: [GIT PULL] ARM: tegra: fixes for 3.7-rc4
Message-ID: <1351784594-28982-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we have just a single fix for the Tegra30 pinctrl module's register
range size in device tre.

----------------------------------------------------------------

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

  Linux 3.7-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-fixes-for-rc4

for you to fetch changes up to 322337b8fbd8c392246529d5db924820fc0c7381:

  ARM: dt: tegra: fix length of pad control and mux registers

----------------------------------------------------------------

Pritesh Raithatha (1):
      ARM: dt: tegra: fix length of pad control and mux registers

 arch/arm/boot/dts/tegra30.dtsi |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
