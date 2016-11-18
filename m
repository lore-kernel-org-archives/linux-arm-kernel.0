From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 18 Nov 2016 17:17:19 +0100
Subject: [GIT PULL 10/10] arm64: tegra: Default configuration updates for
 v4.10-rc1
In-Reply-To: <20161118161719.24153-1-thierry.reding@gmail.com>
References: <20161118161719.24153-1-thierry.reding@gmail.com>
Message-ID: <20161118161719.24153-10-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.10-arm64-defconfig

for you to fetch changes up to c6299451bb45bf3370cc3aa53891fb9d48bed774:

  arm64: defconfig: Enable Tegra186 SoC (2016-11-15 16:26:03 +0100)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Default configuration updates for v4.10-rc1

Enable Tegra186 support.

----------------------------------------------------------------
Joseph Lo (1):
      arm64: defconfig: Enable Tegra186 SoC

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
