From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 13 Feb 2018 14:18:04 +0300
Subject: [PATCH v2 0/2] Add R8A77970/Eagle GPIO support
Message-ID: <038a791d-aa57-9c3d-eaea-09c5704ecb54@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180213-v4.16-rc1' tag. We're adding the R8A77970 GPIO
nodes and then describing the PHY IRQ for EtherAVB device declared earlier.

[1/2] arm64: dts: renesas: r8a77970: add GPIO support
[2/2] arm64: dts: renesas: eagle: specify EtherAVB PHY IRQ

WBR, Sergei
