From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 18:34:49 +0000
Subject: [GIT PULL] arm-soc: Xilinx zynq serial changes for v3.9
In-Reply-To: <CAHTX3dJGHK7nO2tx_kUWLwhpgNsCwtnjXAJnRFUOHVx2uE589Q@mail.gmail.com>
References: <CAHTX3dJGHK7nO2tx_kUWLwhpgNsCwtnjXAJnRFUOHVx2uE589Q@mail.gmail.com>
Message-ID: <201301211834.49512.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Michal Simek wrote:
>   git://git.xilinx.com/linux-xlnx.git zynq/serial
> 
> Josh Cartwright (1):
>       serial: xilinx_uartps: get clock rate info from dts
> 
> Wei Yongjun (1):
>       serial: xilinx_uartps: fix return value check in xuartps_probe()
> 
>  arch/arm/boot/dts/zynq-7000.dtsi   |    4 ++--
>  drivers/tty/serial/xilinx_uartps.c |   34 +++++++++++++++++++---------------
>  2 files changed, 21 insertions(+), 17 deletions(-)

The patches look good, and they should get merged through Greg's tree.

Acked-by: Arnd Bergmann <arnd@arndb.de>
