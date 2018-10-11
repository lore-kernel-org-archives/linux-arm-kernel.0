From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 11 Oct 2018 12:24:24 +0200
Subject: [GIT PULL 3/5 v2] firmware: tegra: Changes for v4.20-rc1
In-Reply-To: <20180927205942.30878-3-thierry.reding@gmail.com>
References: <20180927205942.30878-3-thierry.reding@gmail.com>
Message-ID: <20181011102424.22720-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.20-firmware-2

for you to fetch changes up to 00cba11fab58407a0017fc55476ea764161c5f07:

  firmware: tegra: bpmp: Implement suspend/resume support (2018-10-10 16:47:22 +0200)

This took longer than I anticipated because I managed to somehow break
my git tree along the way. This is equivalent to the first pull request
except that it also fixes the warning that Arnd reported.

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
