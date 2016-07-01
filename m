From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  1 Jul 2016 16:50:23 +0200
Subject: [GIT PULL 3/6] memory: tegra: Changes for v4.8-rc1
In-Reply-To: <20160701145026.25760-1-thierry.reding@gmail.com>
References: <20160701145026.25760-1-thierry.reding@gmail.com>
Message-ID: <20160701145026.25760-3-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.8-memory

for you to fetch changes up to 55bb1d8355ce91662dc8760f24f578db5a595819:

  memory: tegra: mc: Add missing of_node_put() (2016-06-14 11:39:39 +0200)

Thanks,
Thierry

----------------------------------------------------------------
memory: tegra: Changes for v4.8-rc1

Contains three reference count fixes from coccinelle.

----------------------------------------------------------------
Amitoj Kaur Chawla (2):
      memory: tegra: tegra124-emc: Add missing of_node_put()
      memory: tegra: mc: Add missing of_node_put()

Julia Lawall (1):
      memory: tegra: Delete unneeded of_node_put()

 drivers/memory/tegra/mc.c           | 10 +++++-----
 drivers/memory/tegra/tegra124-emc.c |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)
