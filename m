From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 3 Jan 2017 10:28:00 +0000
Subject: [GIT PULL] firmware: SCPI: fixes for v4.10
Message-ID: <11909baf-8ab3-7e53-ef22-2988571392f5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Please pull !

Regards,
Sudeep

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/scpi-fixes-4.10

for you to fetch changes up to a766347b15c01507db9bf01f9b7021be5a776691:

  firmware: arm_scpi: fix reading sensor values on pre-1.0 SCPI
firmwares (2016-12-30 14:53:36 +0000)

----------------------------------------------------------------
SCPI fix for v4.10

A simple fix for reading only lower 32-bit sensor values on pre-1.0 SCPI
firmwares so that upper 32-bit (garbage) value is discarded properly.

----------------------------------------------------------------
Martin Blumenstingl (1):
      firmware: arm_scpi: fix reading sensor values on pre-1.0 SCPI
firmwares

 drivers/firmware/arm_scpi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
