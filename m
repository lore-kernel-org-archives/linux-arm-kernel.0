From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 21 Aug 2018 22:48:09 +0300
Subject: [PATCH 0/2] Add R8A77980/Condor eMMC support
Message-ID: <1af46bf9-d9e5-8dcf-0ac7-a85e7348a34e@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180810-v4.18-rc7' tag. We're adding the R8A77970 MMC0
(SDHI2) device nodes and then enable eMMC support on the V3M Starter Kit
board. The SDHI (w/internal DMA) driver patch white-listing the R8A77970
was posted last Saturday; the R8A77970 CPG/MSSR driver patch and the SDHI
bindings patch have been posted earlier today.

[1/2] arm64: dts: renesas: r8a77970: add MMC support
[2/2] arm64: dts: renesas: v3msk: add eMMC support

WBR, Sergei
