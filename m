From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon,  2 Feb 2015 13:03:12 -0800
Subject: [GIT PULL 1/2] soc: ti: Keystone Navigator SOC driver updates for 3.20
Message-ID: <1422910993-4634-1-git-send-email-santosh.shilimkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers-soc-ti

for you to fetch changes up to a68094c67bf1fa86630bd011d2d212899c41e1bc:

  soc: ti: knav_qmss_queue: change knav_range_setup_acc_irq to static (2015-01-29 13:23:51 -0800)

----------------------------------------------------------------
Keystone Navigator SOC driver updates for 3.20

	- Makefile tweak so that knav_qmss and knav_dma can be made loadable
		modules without depedency issues.
	- Few more exports to support ARM allmodconfig.
	- Marking knav_range_setup_acc_irq() local function as static.

----------------------------------------------------------------
Murali Karicheri (3):
      soc: ti: knav_qmss_queue: export API calls for use by user driver
      soc: ti: knav_qmss_queue: makefile tweak to build as dynamic module
      soc: ti: knav_qmss_queue: change knav_range_setup_acc_irq to static

 drivers/soc/ti/Makefile          | 3 ++-
 drivers/soc/ti/knav_qmss_acc.c   | 2 +-
 drivers/soc/ti/knav_qmss_queue.c | 9 +++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)
