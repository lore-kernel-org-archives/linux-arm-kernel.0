From: yang.shi@linaro.org (Shi, Yang)
Date: Tue, 26 Jan 2016 16:02:40 -0800
Subject: 4.5-rc1 kernel is failed to bootup on FSL LS2080 RDB board
Message-ID: <56A80920.8030504@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,

I tried to boot 4.5-rc1 kernel on my FSL LS2080 RDB (aka LS2085 RDB), 
but it is failed silently. If I use the dtb file shipped with the SDK 
with 4.5-rc1 kernel, I can get the serial console output, but it is 
failed to detect PCI bus.

If I use both kernel and dtb from the SDK, it works well.

The bootloader information:

U-Boot 2015.07-rc1Layerscape2-SDK+g7e8bad0 (Aug 27 2015 - 14:31:42)

SoC:  LS2085E (0x87010010)
Clock Configuration:
        CPU0(A57):1600 MHz  CPU1(A57):1600 MHz  CPU2(A57):1600 MHz
        CPU3(A57):1600 MHz  CPU4(A57):1600 MHz  CPU5(A57):1600 MHz
        CPU6(A57):1600 MHz  CPU7(A57):1600 MHz
        Bus:      600  MHz  DDR:      1333.333 MT/s     DP-DDR: 
1333.333 MT/s
Reset Configuration Word (RCW):
        00: 40282830 40400040 00000000 00000000
        10: 00000000 00200000 00200000 00000000
        20: 00c12980 00002580 00000000 00000000
        30: 00000e0b 00000000 00000000 00000000
        40: 00000000 00000000 00000000 00000000
        50: 00000000 00000000 00000000 00000000
        60: 00000000 00000000 00027000 00000000
        70: 412a0000 00000000 00000000 00000000
Model: Freescale Layerscape 2085a RDB Board
Board: LS2085E-RDB, Board Arch: V1, Board version: D, boot from vBank: 4
FPGA: v1.18

And, I have ARCH_LAYERSCAPE, CONFIG_PCIE_DW and CONFIG_PCI_LAYERSCAPE 
enabled.

Any hint is appreciated.

Thanks,
Yang
