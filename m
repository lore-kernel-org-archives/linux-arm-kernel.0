From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 6 Apr 2018 23:11:38 +0300
Subject: [PATCH 0/3] Add R8A77980/Condor PCIe support
Message-ID: <f07e6173-75b3-fe10-81d6-915942a5f4fe@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 3 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180330-v4.16-rc7' tag. We're adding the R8A77980 PCIe related
device nodes and then enable PCIe on the Condor board. These patches depend on
the R8A77980 PCIe PHY and PCIEC driver support in order to work properly...

[1/3] arm64: dts: renesas: r8a77980: add PCIe PHY support
[2/3] arm64: dts: renesas: r8a77980: add PCIEC support
[3/3] arm64: dts: renesas: condor: add PCIe support

WBR, Sergei
