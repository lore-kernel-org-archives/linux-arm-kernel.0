From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 06 Oct 2016 00:23:55 +0300
Subject: [PATCH v3 0/11] Add R8A7743/SK-RZG1M board support
Message-ID: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 11 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20161003-v4.8' tag. I'm adding the device tree support for
the R8A7743-based SK-RZG1M board. The SoC is close to R8A7791 and the board
seems identical to the R8A7791/Porter board. The device tree patches depend on
the R8A7743 CPG/MSSR driver series just posted in order to compile and work.

[01/12] ARM: shmobile: r8a7743: add power domain index macros
[02/12] soc: renesas: rcar-sysc: add R8A7743 support
[03/12] ARM: shmobile: r8a7743: basic SoC support
[04/12] ARM: dts: r8a7743: initial SoC device tree
[05/12] ARM: dts: r8a7743: add SYS-DMAC support
[06/12] ARM: dts: r8a7743: add [H]SCIF{A|B} support
[07/12] ARM: dts: r8a7743: add Ether support
[08/12] ARM: dts: r8a7743: add IRQC support
[09/12] DT: arm: shmobile: document SK-RZG1M board
[10/12] ARM: dts: sk-rzg1m: initial device tree
[11/12] ARM: dts: sk-rzg1m: add Ether support

WBR, Sergei
