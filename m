From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 06 Aug 2013 12:14:46 +0300
Subject: [PATCH 1/2] ARM: msm: Add support for MSM8974 Dragonboard
In-Reply-To: <1375743779-24993-1-git-send-email-rvaswani@codeaurora.org>
References: <1375743779-24993-1-git-send-email-rvaswani@codeaurora.org>
Message-ID: <1375780486.2725.7.camel@iivanov-dev.int.mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-08-05 at 16:02 -0700, Rohit Vaswani wrote:
> This patch adds basic board support for MSM8974 Dragonboard
> which belongs to the Snapdragon 800 family.
> For now, just support a basic machine with device tree.
> 
> Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
> ---
>  arch/arm/boot/dts/Makefile        |  3 ++-
>  arch/arm/boot/dts/msm8974-db.dts  | 26 ++++++++++++++++++++++++++
>  arch/arm/mach-msm/Kconfig         | 21 ++++++++++++++++++---
>  arch/arm/mach-msm/Makefile        |  1 +
>  arch/arm/mach-msm/board-dt-8974.c | 23 +++++++++++++++++++++++
>  5 files changed, 70 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/boot/dts/msm8974-db.dts
>  create mode 100644 arch/arm/mach-msm/board-dt-8974.c

Thanks. 

Tested-by: Ivan T. Ivanov <iivanov@mm-sol.com>

Attached patch enables earlyprink for this board.

[920] booting linux @ 0x8000, ramdisk @ 0x2000000 (1067699), tags/device tree @ 0x1e00000
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.11.0-rc4-00003-g7c8394e (iivanov at dev) (gcc version 4.6.3 (GCC) ) #502 SMP PREEMPT Tue Aug 6 12:09:07 EEST3
[    0.000000] CPU: ARMv7 Processor [512f06f0] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine: Qualcomm MSM (Flattened Device Tree), model: Qualcomm MSM8974 Dragonboard
....

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-msm-Add-low-level-debugging-via-MSM-8974-UART.patch
Type: text/x-patch
Size: 2479 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130806/5a89d9fb/attachment.bin>
