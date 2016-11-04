From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 05 Nov 2016 00:42:33 +0300
Subject: [PATCH v2 0/11] Add R8A7745/SK-RZG1E board support
Message-ID: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 11 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-201611104-v4.9-rc3' tag plus the R8A7743/SK-RZG1M patch series
posted earlier. I'm adding the device tree support for the R8A7745-based
SK-RZG1E board. The SoC is close to R8A7794 and the board seems identical to the
R8A7794/SILK board. The device tree patches depend on the R8A7745 CPG/MSSR
driver series in order to compile and work.

[01/11] ARM: shmobile: r8a7745: add power domain index macros
[02/11] soc: renesas: rcar-sysc: add R8A7745 support
[03/11] ARM: shmobile: r8a7745: basic SoC support
[04/11] ARM: dts: r8a7745: initial SoC device tree
[05/11] ARM: dts: r8a7745: add SYS-DMAC support
[06/11] ARM: dts: r8a7745: add [H]SCIF{|A|B} support
[07/11] ARM: dts: r8a7745: add Ether support
[08/11] ARM: dts: r8a7745: add IRQC support
[09/11] ARM: shmobile: document SK-RZG1E board
[10/11] ARM: dts: sk-rzg1e: initial device tree
[11/11] ARM: dts: sk-rzg1e: add Ether support

WBR, Sergei
