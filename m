From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 26 Jan 2018 09:46:29 +0100
Subject: [GIT PULL] ARM64: Xilinx ZynqMP SoC fixes for v4.16
Message-ID: <95bccf81-43f4-74d1-c6f2-0c683013c06a@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

please consider to pull these 3 patches to your tree for v4.16. Up to
you if you want to queue for -rc1 or later. That's why it is labeled as fix.

Branch is based on
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=xlnx/soc
and contain 3 fixes. One is purely coding style fix(my top one) and
other two were reported by testing systems which weren't spotted in review.

Thanks,
Michal


The following changes since commit cee8113a295acfc4cd25728d7c3d44e6bc3bbff9:

  soc: xilinx: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver
(2018-01-08 13:42:47 +0100)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-soc-fixes-for-4.16

for you to fetch changes up to 056b54eeaebbe567076fe9e824643fc330cba4d5:

  soc: xilinx: Fix Kconfig alignment (2018-01-16 15:50:21 +0100)

----------------------------------------------------------------
arm: Xilinx ZynqMP SoC fixes for v4.16

- Fix Kconfig dependency
- Fix vcu clkoutdiv calculation

----------------------------------------------------------------
Dhaval Shah (1):
      soc: xilinx: xlnx_vcu: Depends on HAS_IOMEM for xlnx_vcu

Gustavo A. R. Silva (1):
      soc: xilinx: xlnx_vcu: Use bitwise & rather than logical && on
clkoutdiv

Michal Simek (1):
      soc: xilinx: Fix Kconfig alignment

 drivers/soc/xilinx/Kconfig    | 21 +++++++++++----------
 drivers/soc/xilinx/xlnx_vcu.c |  2 +-
 2 files changed, 12 insertions(+), 11 deletions(-)
This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
