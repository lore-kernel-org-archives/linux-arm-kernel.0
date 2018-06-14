From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 14 Jun 2018 22:16:32 +0300
Subject: [PATCH v2 0/2] Add R8A77980/Condor PCIe support
Message-ID: <b37d458c-071a-833a-2057-be8a07c880be@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180614v2-v4.17' tag. We're adding the R8A77980 PCIe related
device nodes and then enable PCIe on the Condor board. These patches depend
on the R8A77980 PCIe PHY driver support in order to work properly. Note that
in case the PCIe PHY driver is not enabled, the kernel will BUG() due to I/O
space page leak in the PCIe driver...

[1/2] arm64: dts: renesas: r8a77980: add PCIe support
[2/2] arm64: dts: renesas: condor: add PCIe support

WBR, Sergei
