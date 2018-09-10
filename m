From: jolly.shah@xilinx.com (Jolly Shah)
Date: Mon, 10 Sep 2018 13:01:31 -0700
Subject: [PATCH 0/3]  drivers: firmware: xilinx: Minor fixes
Message-ID: <1536609694-7920-1-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is created on top of commit bca7067d2d4e91f58162b07d73cd94e20437b4f6 from below git repository:
https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-soc-for-v4.20

It contains 1 pending patch from v11 patchset and 2 patches to fix minor review comments received from Olof Johansson.

Rajan Vaja (3):
  firmware: xilinx: Replace init call with probe method
  firmware: xilinx: Move declaration of qdata to top of the function
  firmware: xilinx: Replace if/else with switch case

 drivers/firmware/xilinx/zynqmp-debug.c | 15 ++++----
 drivers/firmware/xilinx/zynqmp.c       | 63 ++++++++++------------------------
 2 files changed, 26 insertions(+), 52 deletions(-)

-- 
2.7.4
