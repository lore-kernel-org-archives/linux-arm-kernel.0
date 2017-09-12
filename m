From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 12 Sep 2017 23:37:16 +0300
Subject: [PATCH 00/11] Add R8A77970/Eagle board support
Message-ID: <20170912203716.238067587@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 11 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20170911v2-v4.13' tag. I'm adding the device tree support for
the R8A77970-based Eagle board. The necessary SYS-DMAC, [H]SCIF, and EtherAVB
bindings updates have been posted earlier.

[01/11] soc: renesas: identify R-Car V3M
[02/11] soc: renesas: rcar-rst: add R8A77970 support
[03/11] dt-bindings: power: add R8A77970 SYSC power domain definitions
[04/11] soc: renesas: rcar-sysc: add R8A77970 support
[05/11] arm64: dts: renesas: initial R8A77970 SoC device tree
[06/11] arm64: dts: renesas: r8a77970: add SYS-DMAC support
[07/11] arm64: dts: renesas: r8a77970: add [H]SCIF support
[08/11] arm64: dts: renesas: r8a77970: add EtherAVB support
[09/11] arm64: renesas: document Eagle board
[11/11] arm64: dts: renesas: initial Eagle board device tree
[11/11] arm64: dts: renesas: eagle: add EtherAVB support

WBR, Sergei
