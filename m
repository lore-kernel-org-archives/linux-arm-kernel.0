From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 2 Feb 2018 21:18:33 +0300
Subject: [PATCH 00/11] Add R8A77980/Condor board support
Message-ID: <46fca582-220d-e5a7-62cd-2fc77a29846b@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 11 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180202-v4.15' tag. I'm adding the device tree support for
the R8A77980-based Condor board (note that NFS root would only work on the
Condor boards [re]wired for booting from EtherAVB -- we haven't been able
to get the 'sh_eth' driver working in either U-Boot or Linux so far).
The necessary SYS-DMAC, [H]SCIF, and EtherAVB bindings updates have been
posted yesterday, the clock driver was posted the day before...

[01/11] soc: renesas: identify R-Car V3H
[02/11] soc: renesas: rcar-rst: add R8A77980 support
[03/11] dt-bindings: power: add R8A77980 SYSC power domain definitions
[04/11] soc: renesas: rcar-sysc: add R8A77980 support
[05/11] arm64: dts: renesas: initial R8A77980 SoC device tree
[06/11] arm64: dts: renesas: r8a77980: add SYS-DMAC support
[07/11] arm64: dts: renesas: r8a77980: add [H]SCIF support
[08/11] arm64: dts: renesas: r8a77980: add EtherAVB support
[09/11] DT: arm: shmobile: document Condor board bindings
[10/11] arm64: dts: renesas: initial Condor board device tree
[11/11] arm64: dts: renesas: condor: add EtherAVB support

WBR, Sergei
