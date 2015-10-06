From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Tue,  6 Oct 2015 10:19:18 -0700
Subject: [GIT PULL 1/3] Keystone SOC driver updates for 4.4 
Message-ID: <1444151960-4941-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-driver-soc

for you to fetch changes up to dc21221c9d4c2b53ab724a8f67b1866b0958e60f:

  soc: ti: display firmware file name as part of boot log (2015-09-17 09:05:16 -0700)

----------------------------------------------------------------
Couple of patches for ARM Keystone SOC drivers
        - irq affinity bug fix
        - display the firmware name

----------------------------------------------------------------
Murali Karicheri (2):
      soc: ti: reset irq affinity before freeing irq
      soc: ti: display firmware file name as part of boot log

 .../bindings/soc/ti/keystone-navigator-qmss.txt      | 20 +++++++++++++++++++-
 drivers/soc/ti/knav_qmss_acc.c                       |  4 ++++
 drivers/soc/ti/knav_qmss_queue.c                     |  3 +++
 3 files changed, 26 insertions(+), 1 deletion(-)
