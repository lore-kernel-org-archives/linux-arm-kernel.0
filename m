From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 29 Oct 2016 01:04:56 +0300
Subject: [PATCH 0/11] Add R8A7745/SK-RZG1E board support
Message-ID: <4121805.SRTmqJtRfv@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 11 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20161027-v4.9-rc2' tag plus the R8A7743/SK-RZG1M patch series.
I'm adding the device tree support for the R8A7745-based SK-RZG1E board.
The SoC is close to R8A7794 and the board seems identical to the R8A7794/SILK
board. The device tree patches depend on the R8A7745 CPG/MSSR driver series
just posted in order to compile and work.

[01/12] ARM: shmobile: r8a7745: add power domain index macros
[02/12] soc: renesas: rcar-sysc: add R8A7745 support
[03/12] ARM: shmobile: r8a7745: basic SoC support
[04/12] ARM: dts: r8a7745: initial SoC device tree
[05/12] ARM: dts: r8a7745: add SYS-DMAC support
[06/12] ARM: dts: r8a7745: add [H]SCIF{A|B} support
[07/12] ARM: dts: r8a7745: add Ether support
[08/12] ARM: dts: r8a7745: add IRQC support
[09/12] ARM: shmobile: document SK-RZG1M board
[10/12] ARM: dts: sk-rzg1e: initial device tree
[11/12] ARM: dts: sk-rzg1e: add Ether support

WBR, Sergei
