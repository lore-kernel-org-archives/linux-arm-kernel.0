From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 16 Jun 2017 10:13:04 +0200
Subject: [GIT PULL 2/4] firmware: tegra: Changes for v4.13-rc1
In-Reply-To: <20170616081306.11505-1-thierry.reding@gmail.com>
References: <20170616081306.11505-1-thierry.reding@gmail.com>
Message-ID: <20170616081306.11505-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.13-firmware

for you to fetch changes up to cd307124ad9bb01019920c2053696218d161f4a1:

  firmware: tegra: Fix locking bugs in BPMP (2017-06-14 17:17:32 +0200)

Thanks,
Thierry

----------------------------------------------------------------
firmware: tegra: Changes for v4.13-rc1

This contains a fix for missing semaphore release in error paths as well
as a bogus error code return in the BPMP firmware implementation.

----------------------------------------------------------------
Dan Carpenter (1):
      firmware: tegra: Fix locking bugs in BPMP

 drivers/firmware/tegra/bpmp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)
