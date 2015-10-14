From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Wed, 14 Oct 2015 08:37:37 -0700
Subject: [GIT PULL 1/2] Keystone SOC driver update for 4.4
Message-ID: <1444837058-3525-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-driver-soc_v2

for you to fetch changes up to 045016902bf7abeeb2a86fc9284c30dce228f055:

  soc: ti: qmss: make acc queue support optional in the driver (2015-10-13 13:49:04 -0700)

----------------------------------------------------------------
ARM Keystone SOC driver updates for 4.4
	Documentation and support to be able to load the PDSP
	firmware necessary for accumulator operation.

----------------------------------------------------------------
Murali Karicheri (3):
      Documentation: dt: soc: Add description for knav qmss driver
      soc: ti: add firmware file name as part of the driver
      soc: ti: qmss: make acc queue support optional in the driver

 Documentation/arm/keystone/knav-qmss.txt           | 56 ++++++++++++++++++
 .../bindings/soc/ti/keystone-navigator-qmss.txt    |  1 -
 drivers/soc/ti/knav_qmss.h                         |  3 +-
 drivers/soc/ti/knav_qmss_acc.c                     | 10 +++-
 drivers/soc/ti/knav_qmss_queue.c                   | 67 ++++++++++++++--------
 5 files changed, 109 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/arm/keystone/knav-qmss.txt
