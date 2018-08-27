From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 27 Aug 2018 21:48:53 +0300
Subject: [PATCH v2 0/2] Add R8A77980/Condor PCIe support
Message-ID: <fb4eb097-40aa-82df-68c7-9b727c858a8b@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180827-v4.19-rc1' tag. We're adding the R8A77980 PCIe
related device nodes and then enable PCIe on the Condor board.

[1/2] arm64: dts: renesas: r8a77980: add PCIe support
[2/2] arm64: dts: renesas: condor: add PCIe support

WBR, Sergei
