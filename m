From: abhilash.kv@ti.com (Abhilash K V)
Date: Fri, 19 Aug 2011 17:22:29 +0530
Subject: [PATCH 0/2] AM3517EVM: Add support for MMC1
Message-ID: <1313754751-11752-1-git-send-email-abhilash.kv@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set adds support for MMC1 slot on the 
AM3517 EVM's base-board.
These patches are dependent on the following patch-set
http://marc.info/?l=linux-omap&m=131247357813228&w=2
which gets the AM3517 EVM booting.

The patches are tested on master of tmlind/linux-omap-2.6.git.
Kernel version is 3.0.0-rc7 and last commit on top of which these patches
were added is:

        885cf6ff7d3dad4cc44be74b0577d3a554d3ab71: Linux-omap rebuilt:
        Updated to -rc7, added new boards

Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
Abhilash K V (1):
  AM3517: Support for MMC1

Vaibhav Hiremath (1):
  AM3517EVM: Add support for base-board MMC slot

 arch/arm/mach-omap2/board-am3517evm.c |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/hsmmc.c           |   10 +++++++++-
 2 files changed, 31 insertions(+), 1 deletions(-)
