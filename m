From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 16 Nov 2017 23:56:47 +0300
Subject: [PATCH 0/1] Add R8A77970/Eagle I2C support
Message-ID: <20171116205647.152964720@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20171113-v4.14' tag. We're adding the R8A77970 I2C nodes
and then describing the PCA9654 I/O expander connected to the I2C0 bus.
These patches depend on the R8A77970/Eagle PFC suport patchset in order
to apply/compile.

[1/2] arm64: dts: renesas: r8a77970: add I2C support
[2/2] arm64: dts: renesas: eagle: add I2C support

WBR, Sergei
