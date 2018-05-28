From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 28 May 2018 23:10:52 +0300
Subject: [PATCH v3 0/2] Add R8A77980/Condor I2C support
Message-ID: <e9c94553-be9d-0eec-a1ee-1713bb97fbab@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180528-v4.17-rc7' tag. We're adding the R8A77980 I2C nodes
and then describing 2 PCA9654 I/O expanders connected to the I2C0 bus on
the Condor board.

[1/2] arm64: dts: renesas: r8a77980: add I2C support
[2/2] arm64: dts: renesas: condor: add I2C0 support

WBR, Sergei
