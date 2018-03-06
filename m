From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon,  5 Mar 2018 16:41:13 -0800
Subject: [GIT PULL 2/2] SOC: Couple of drivers changes for v4.17
In-Reply-To: <1520296873-12982-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1520296873-12982-1-git-send-email-santosh.shilimkar@oracle.com>
Message-ID: <1520296873-12982-2-git-send-email-santosh.shilimkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/soc_drivers_for_4.17

for you to fetch changes up to a817e5d82a2dc5daaa0a8a66cfab268fdf2f6bb6:

  memory: ti-emif-sram: remove redundant dev_err call in ti_emif_probe() (2018-03-05 16:21:31 -0800)

----------------------------------------------------------------
SOC driver changes for v4.17

 - Remove deundant dev_err from probe in ti-emif-srma driver
 - Make use of seq_putc in emif reg show

----------------------------------------------------------------
SF Markus Elfring (1):
      memory-EMIF: Use seq_putc() in emif_regdump_show()

Wei Yongjun (1):
      memory: ti-emif-sram: remove redundant dev_err call in ti_emif_probe()

 drivers/memory/emif.c       | 2 +-
 drivers/memory/ti-emif-pm.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)
