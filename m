From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Sep 2018 22:59:40 +0200
Subject: [GIT PULL 3/5] firmware: tegra: Changes for v4.20-rc1
In-Reply-To: <20180927205942.30878-1-thierry.reding@gmail.com>
References: <20180927205942.30878-1-thierry.reding@gmail.com>
Message-ID: <20180927205942.30878-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.20-firmware

for you to fetch changes up to cd40f6ff124ce4a020d589f5c2727a69dd1ca176:

  firmware: tegra: bpmp: Implement suspend/resume support (2018-09-26 16:02:55 +0200)

Thanks,
Thierry

----------------------------------------------------------------
firmware: tegra: Changes for v4.20-rc1

This contains a fix for suspend/resume support for the BPMP found on
Tegra186 and Tegra194.

----------------------------------------------------------------
Thierry Reding (1):
      firmware: tegra: bpmp: Implement suspend/resume support

 drivers/firmware/tegra/bpmp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
