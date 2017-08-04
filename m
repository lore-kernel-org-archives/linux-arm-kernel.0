From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Fri, 4 Aug 2017 11:32:49 +0200
Subject: [GIT PULL] tee: updates for v4.14
Message-ID: <20170804093153.GA16698@jax>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

The following changes since commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973:

  Linux 4.13-rc3 (2017-07-30 12:40:36 -0700)

are available in the git repository at:

  http://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-drv-for-4.14

for you to fetch changes up to 39e6519a3f135b143dee4d4fb5ac0438e75454e2:

  tee: optee: sync with new naming of interrupts (2017-08-04 10:30:27 +0200)

----------------------------------------------------------------
Small fixes and enhancements for the TEE subsystem

----------------------------------------------------------------
Arvind Yadav (1):
      tee: tee_shm: Constify dma_buf_ops structures.

Bhumika Goyal (1):
      tee: optee: add const to tee_driver_ops and tee_desc structures

David Wang (1):
      tee: optee: sync with new naming of interrupts

Jens Wiklander (2):
      tee: optee: fix uninitialized symbol 'parg'
      tee: indicate privileged dev in gen_caps

Jerome Forissier (1):
      tee: add forward declaration for struct device

tiger-yu99 (1):
      tee: optee: interruptible RPC sleep

 drivers/tee/optee/core.c      | 19 ++++++++++---------
 drivers/tee/optee/optee_smc.h | 12 ++++++------
 drivers/tee/optee/rpc.c       | 15 ++++++---------
 drivers/tee/tee_core.c        |  5 +++++
 drivers/tee/tee_shm.c         |  2 +-
 include/linux/tee_drv.h       |  1 +
 include/uapi/linux/tee.h      |  1 +
 7 files changed, 30 insertions(+), 25 deletions(-)
