From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 12 Jul 2018 17:41:26 +0200
Subject: [GIT PULL 3/5] firmware: tegra: Changes for v4.19-rc1
In-Reply-To: <20180712154128.22705-1-thierry.reding@gmail.com>
References: <20180712154128.22705-1-thierry.reding@gmail.com>
Message-ID: <20180712154128.22705-4-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.19-firmware

for you to fetch changes up to 4ea7bdc6b5b33427bbd3f41c333e21c1825462a3:

  ARM: trusted_foundations: do not use naked function (2018-07-11 14:40:43 +0200)

Thanks,
Thierry

----------------------------------------------------------------
firmware: tegra: Changes for v4.19-rc1

This contains a single fix for the Trusted Foundations firmware
implementation, used on some Tegra20 and Tegra30 platforms.

----------------------------------------------------------------
Stefan Agner (1):
      ARM: trusted_foundations: do not use naked function

 arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)
