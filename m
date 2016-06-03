From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 04 Jun 2016 00:09:35 +0300
Subject: [PATCH v2 00/11] Add R8A7792/Blanche board support
Message-ID: <3446154.oZ24315zaL@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 11 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160530-v4.7-rc1' tag. We add the device tree support for
the R8A7792-based Blanche board. The R-Car 'clk' driver patch was posted last
week separately and 2 'clk' binding patches was split from this series and just
re-posted...

[01/13] ARM: shmobile: r8a7792: add clock index macros
[02/13] ARM: shmobile: r8a7792: add power domain index macros
[03/13] soc: renesas: rcar-sysc: add R8A7792 support
[04/13] ARM: shmobile: r8a7792: basic SoC support
[05/13] ARM: dts: r8a7792: initial SoC device tree
[06/13] ARM: dts: r8a7792: add SYS-DMAC support
[07/13] ARM: dts: r8a7792: add [H]SCIF support
[08/13] ARM dts: r8a7792: add IRQC support
[09/13] DT: arm: shmobile: document Blanche board
[10/13] ARM: dts: blanche: initial device tree
[11/13] ARM: dts: blanche: add Ethernet support

WBR, Sergei
