From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 9 Mar 2018 15:04:56 +0300
Subject: [PATCH 0/3] Add R8A77980/Condor PFC support
Message-ID: <88e52531-e538-8685-110a-1a2e79a3fe49@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 3 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180308-v4.16-rc4' tag.  We're adding the R8A77980 PFC node
and then describing the pins for SCIF0 and EtherAVB devices declared earlier.
These patches depend on the R8A77980 PFC support in order to work properly.

[1/3] arm64: dts: renesas: r8a77980: add PFC support
[2/3] arm64: dts: renesas: condor: add SCIF0 pins
[3/3] arm64: dts: renesas: condor: add EtherAVB pins

WBR, Sergei
