From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 21 Jan 2013 18:19:03 +0100
Subject: [GIT PULL] arm-soc: Xilinx zynq serial changes for v3.9
Message-ID: <CAHTX3dJGHK7nO2tx_kUWLwhpgNsCwtnjXAJnRFUOHVx2uE589Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof and Greg,

I have two patches for xilinx uartps serial driver (the second one fix
one issue in the first one).
These patches has been sent to arm mailing list and also to
device-tree mailing list.

There is a change in zynq dtsi that's why I think it can go through
arm-soc tree.
Please let me know if this should go through Greg serial tree.

Thanks,
Michal


The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:
  Linus Torvalds (1):
        Linux 3.8-rc4

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git zynq/serial

Josh Cartwright (1):
      serial: xilinx_uartps: get clock rate info from dts

Wei Yongjun (1):
      serial: xilinx_uartps: fix return value check in xuartps_probe()

 arch/arm/boot/dts/zynq-7000.dtsi   |    4 ++--
 drivers/tty/serial/xilinx_uartps.c |   34 +++++++++++++++++++---------------
 2 files changed, 21 insertions(+), 17 deletions(-)
