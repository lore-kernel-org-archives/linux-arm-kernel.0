From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 14 Apr 2018 22:24:57 +0300
Subject: [PATCH 0/2] Add R8A77980/Condor eMMC support
Message-ID: <611daf1f-42a2-d463-0814-ebf762871018@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180412-v4.16' tag. We're adding the R8A77980 MMC (SDHI)
device nodes and then enable eMMC support on the Condor board. These patches
are atop of the recently posted PCIe/PFC R8A77980/Condor patches and they
depend on the R8A77980 SDHI driver support patch (not posted yet) in order
to work properly...

[1/2] arm64: dts: renesas: r8a77980: add MMC support
[2/2] arm64: dts: renesas: condor: add eMMC support

WBR, Sergei
