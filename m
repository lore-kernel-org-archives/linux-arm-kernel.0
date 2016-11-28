From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 28 Nov 2016 17:12:16 +0530
Subject: [GIT PULL 1/4] DaVinci driver updates for v4.10 (part 2)
In-Reply-To: <20161128114219.22325-1-nsekhar@ti.com>
References: <20161128114219.22325-1-nsekhar@ti.com>
Message-ID: <20161128114219.22325-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8e7223fc8626db7c302136747bb68213100d290c:

  bus: davinci: add support for da8xx bus master priority control (2016-11-14 17:20:29 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/drivers-2

for you to fetch changes up to d0c7546f6257b4680a760e3fd0dff8a7cc4600ff:

  memory: da8xx-ddrctl: drop the call to of_flat_dt_get_machine_name() (2016-11-23 20:26:42 +0530)

----------------------------------------------------------------
Fixes for drivers already queued to prevent
section mismatch warnings introduced by them.

----------------------------------------------------------------
Bartosz Golaszewski (2):
      bus: da8xx-mstpri: drop the call to of_flat_dt_get_machine_name()
      memory: da8xx-ddrctl: drop the call to of_flat_dt_get_machine_name()

 drivers/bus/da8xx-mstpri.c    | 4 +---
 drivers/memory/da8xx-ddrctl.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)
