From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 3 Mar 2018 22:02:41 +0300
Subject: [PATCH v3 0/2] Add R8A77970/Eagle I2C support
Message-ID: <23c5b1f4-d92b-455f-7288-5aabd002183a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180301-v4.16-rc3' tag. We're adding the R8A77970 I2C nodes
and then describing the PCA9654 I/O expander connected to the I2C0 bus.

[1/2] arm64: dts: renesas: r8a77970: add I2C support
[2/2] arm64: dts: renesas: eagle: add I2C0 support

WBR, Sergei
