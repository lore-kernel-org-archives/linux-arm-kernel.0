From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 May 2018 16:22:45 +0200
Subject: [GIT PULL 5/5] arm64: tegra: Device tree changes for v4.18-rc1
In-Reply-To: <20180518142245.20242-1-thierry.reding@gmail.com>
References: <20180518142245.20242-1-thierry.reding@gmail.com>
Message-ID: <20180518142245.20242-5-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.18-arm64-dt

for you to fetch changes up to 9df50ba76ac1485b844beffa1f3f5d9659d9cdaf:

  arm64: tegra: Make BCM89610 PHY interrupt as active low (2018-05-03 11:48:16 +0200)

I already sent this out as a fix for v4.17, so if you decide to pick
that up you can ignore this one. I've only included it here in case you
had objections to take it into v4.17 at this point.

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Device tree changes for v4.18-rc1

Contains a single fix for the network PHY interrupt polarity.

----------------------------------------------------------------
Bhadram Varka (1):
      arm64: tegra: Make BCM89610 PHY interrupt as active low

 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
