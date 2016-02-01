From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 1 Feb 2016 18:25:48 +0000
Subject: [GIT PULL] vexpress fixes for v4.5
Message-ID: <56AFA32C.4000901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3:

   Linux 4.5-rc2 (2016-01-31 18:12:16 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git 
tags/vexpress-for-v4.5/fixes-rc2

for you to fetch changes up to aeb2ee5683e51305aff274d8b0a50af69b3ab310:

   arm64: dts: Add missing DMA Abort interrupt to Juno (2016-02-01 
09:59:59 +0000)

----------------------------------------------------------------
vexpress fixes for v4.5

Couple of minor fixes for vexpress platforms:
1. Add missing of_node_put in vexpress config bus
2. Add missing DMA-330 abort interrupt on Juno platforms

----------------------------------------------------------------
Amitoj Kaur Chawla (1):
       bus: vexpress-config: Add missing of_node_put

Robin Murphy (1):
       arm64: dts: Add missing DMA Abort interrupt to Juno

  arch/arm64/boot/dts/arm/juno-base.dtsi | 1 +
  drivers/bus/vexpress-config.c          | 4 +++-
  2 files changed, 4 insertions(+), 1 deletion(-)

-- 
Regards,
Sudeep
