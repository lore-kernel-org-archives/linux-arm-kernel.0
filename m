From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 31 May 2018 23:18:57 +0300
Subject: [PATCH v2 0/2] Add R8A77980/Condor I2C support
Message-ID: <2a88f4e9-0a86-8e6f-0ef2-20913dc9431d@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180529-v4.17-rc7' tag. We're adding the R8A77980 I2C nodes
and then describing 2 PCA9654 I/O expanders connected to the I2C0 bus on
the Condor board.

[1/2] arm64: dts: renesas: r8a77980: add I2C support
[2/2] arm64: dts: renesas: condor: add I2C0 support

WBR, Sergei
