From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 30 Sep 2016 01:14:17 +0300
Subject: [PATCH RFC v2 0/12] Add R8A7743/SK-RZG1M board support
Message-ID: <1987532.PE2ex6PrJ5@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 12 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20160926-v4.8-rc8' tag. I'm adding the device tree support for
the R8A7743-based SK-RZG1M board. The SoC is close to R8A7791 and the board
seems  identical to the R8A7791/Porter board. This version includes the Ether,
so the board should boot with NFS root now. I tried to address all the comments
to the version 1 (except the need to use the new CPG/MSSR drivers -- this one
will be addressed RSN). The DMAC/SCIF/IRQC bindings patches posted recently are
needed for scripts/checkpatch.pl to be happy. :-)

[1/12] ARM: shmobile: r8a7743: add clock index macros
[2/12] ARM: shmobile: r8a7743: add power domain index macros
[3/12] soc: renesas: rcar-sysc: add R8A7743 support
[4/12] ARM: shmobile: r8a7743: basic SoC support
[5/12] ARM: dts: r8a7743: initial SoC device tree
[6/12] ARM: dts: r8a7743: add SYS-DMAC support
[7/12] ARM: dts: r8a7743: add [H]SCIF[AB] support
[8/12] ARM: dts: r8a7743: add Ether support
[9/12] ARM: dts: r8a7743: add IRQC support
[10/12] DT: arm: shmobile: document SK-RZG1M board
[11/12] ARM: dts: sk-rzg1m: initial device tree
[12/12] ARM: dts: sk-rzg1m: add Ether support

WBR, Sergei
