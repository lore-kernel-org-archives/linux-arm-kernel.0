From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 12 Jun 2016 23:47:15 +0300
Subject: [PATCH v5 00/12] Add R8A7792/Blanche board support
Message-ID: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 12 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160606-v4.7-rc2' tag. We add the device tree support for
the R8A7792-based Blanche board. The R-Car 'clk' driver patch was posted
separately and 2 'clk' binding patches were split from this series...

[01/12] ARM: shmobile: r8a7792: add clock index macros
[02/12] ARM: shmobile: r8a7792: add power domain index macros
[03/12] soc: renesas: rcar-sysc: add R8A7792 support
[04/12] ARM: shmobile: r8a7792: basic SoC support
[05/12] ARM: shmobile: r8a7792: add SMP support
[06/12] ARM: dts: r8a7792: initial SoC device tree
[07/12] ARM: dts: r8a7792: add SYS-DMAC support
[08/12] ARM: dts: r8a7792: add [H]SCIF support
[09/12] ARM: dts: r8a7792: add IRQC support
[10/12] DT: arm: shmobile: document Blanche board
[11/12] ARM: dts: blanche: initial device tree
[12/12] ARM: dts: blanche: add Ethernet support

WBR, Sergei
