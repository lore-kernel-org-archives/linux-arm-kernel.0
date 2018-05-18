From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 18 May 2018 22:37:29 +0300
Subject: [PATCH 0/2] Add R8A77980/V3HSK GEther support
Message-ID: <a4230699-e46f-0782-e3b1-22d58b9033c8@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180518-v4.17-rc5' tag plus the R8A77980 SMP support patch.
I'm adding the device tree support for mounting the NFS root on the R8A77980-
based V3H Starter Kit board. The 'sh_eth' driver patches adding R8A77980
GEther support patches needed for these 2 patches to work have been posted
and are close to be merged...

[1/2] arm64: dts: renesas: r8a77980: add GEther support
[2/2] arm64: dts: renesas: v3hsk: add GEther support

WBR, Sergei
