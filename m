From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 20 Oct 2015 15:17:36 +0200
Subject: [GIT PULL 2/4] ARM: tegra: Core SoC changes for v4.4-rc1
In-Reply-To: <1445347058-8834-1-git-send-email-thierry.reding@gmail.com>
References: <1445347058-8834-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1445347058-8834-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.4-soc

for you to fetch changes up to e77b675f8786f38d40fc1562e1275875daf67fef:

  ARM: tegra: paz00: use con_id's to refer GPIO's in gpiod_lookup table (2015-10-02 14:30:57 +0200)

----------------------------------------------------------------
ARM: tegra: Core SoC changes for v4.4-rc1

A single patch to restore rfkill support on AC100.

----------------------------------------------------------------
Dmitry Osipenko (1):
      ARM: tegra: paz00: use con_id's to refer GPIO's in gpiod_lookup table

 arch/arm/mach-tegra/board-paz00.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
