From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 26 Feb 2018 23:48:47 +0300
Subject: [PATCH v2 0/2] Add R8A77970/Eagle I2C support
Message-ID: <3aaa4464-fc85-3fb4-2026-5d9df357bdff@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180226-v4.16-rc3' tag. We're adding the R8A77970 I2C nodes
and then describing the PCA9654 I/O expander connected to the I2C0 bus.

[1/2] arm64: dts: renesas: r8a77970: add I2C support
[2/2] arm64: dts: renesas: eagle: add I2C0 support

WBR, Sergei
