From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 1 Jun 2018 23:41:59 +0300
Subject: [PATCH 0/3] Add R8A77980/Condor/V3HSK GPIO support
Message-ID: <4acc208e-c593-1e8a-00ca-fc9a5574074e@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 3 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180529-v4.17-rc7' tag plus the I2C patches reposted yesterday.
We're adding the R8A77980 GPIO nodes and then describing the PHY IRQ for the
GEther/EtherAVB devices declared earlier.

[1/3] arm64: dts: renesas: r8a77980: add GPIO support
[2/3] arm64: dts: renesas: condor: specify EtherAVB PHY IRQ
[3/3] arm64: dts: renesas: v3hsk: specify GEther PHY IRQ

WBR, Sergei
