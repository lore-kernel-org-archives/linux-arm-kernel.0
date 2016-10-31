From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 31 Oct 2016 22:52:25 +0300
Subject: [PATCH v6 0/7] Add R8A7743/SK-RZG1M board support
Message-ID: <1746536.qobnGdHRfV@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 7 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20161031-v4.9-rc3' tag. I'm adding the device tree support for
the R8A7743-based SK-RZG1M board. The SoC is close to R8A7791 and the board
seems identical to the R8A7791/Porter board. The device tree patches depend on
the R8A7743 CPG/MSSR driver series in order to compile and work. Already merged
patches from this series won't be re-posted.

[1/7] ARM: dts: r8a7743: initial SoC device tree
[2/7] ARM: dts: r8a7743: add SYS-DMAC support
[3/7] ARM: dts: r8a7743: add [H]SCIF{A|B} support
[4/7] ARM: dts: r8a7743: add Ether support
[5/7] ARM: dts: r8a7743: add IRQC support
[6/7] ARM: dts: sk-rzg1m: initial device tree
[7/7] ARM: dts: sk-rzg1m: add Ether support

WBR, Sergei
