From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 10 Nov 2017 23:02:18 +0300
Subject: [PATCH 0/3] Add R8A77970/Eagle PFC support
Message-ID: <20171110200218.747996672@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 3 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20171110-v4.14-rc8' tag.  We're adding the R8A77970 PFC node
and then describing the pins for SCIF0 and EtherAVB devices declared earlier.
These patches depend on the R8A77970 PFC suport in order to work properly.

[1/3] arm64: dts: renesas: r8a77970: add PFC support
[2/3] arm64: dts: renesas: eagle: add SCIF0 pins
[3/3] arm64: dts: renesas: eagle: add EtherAVB pins

WBR, Sergei
