From: monstr@monstr.eu (Michal Simek)
Date: Mon, 21 Jan 2013 19:53:39 +0100
Subject: [GIT PULL] arm-soc: Xilinx zynq serial changes for v3.9
In-Reply-To: <201301211834.49512.arnd@arndb.de>
References: <CAHTX3dJGHK7nO2tx_kUWLwhpgNsCwtnjXAJnRFUOHVx2uE589Q@mail.gmail.com>
 <201301211834.49512.arnd@arndb.de>
Message-ID: <CAHTX3dL4ii9ry2d+fNXYBWoiRC6cJWJDvk8Mo1vDv4gAWNP+sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/21 Arnd Bergmann <arnd@arndb.de>:
> On Monday 21 January 2013, Michal Simek wrote:
>>   git://git.xilinx.com/linux-xlnx.git zynq/serial
>>
>> Josh Cartwright (1):
>>       serial: xilinx_uartps: get clock rate info from dts
>>
>> Wei Yongjun (1):
>>       serial: xilinx_uartps: fix return value check in xuartps_probe()
>>
>>  arch/arm/boot/dts/zynq-7000.dtsi   |    4 ++--
>>  drivers/tty/serial/xilinx_uartps.c |   34 +++++++++++++++++++---------------
>>  2 files changed, 21 insertions(+), 17 deletions(-)
>
> The patches look good, and they should get merged through Greg's tree.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

ok.

Thanks,
M

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian
