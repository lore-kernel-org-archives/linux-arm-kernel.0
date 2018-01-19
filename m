From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 19 Jan 2018 22:42:33 +0300
Subject: [PATCH 0/5] Add R8A77970/V3MSK LVDS/HDMI support
Message-ID: <20180119194233.615400015@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 5 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180119-v4.15-rc8' tag. We're adding the R8A77970 FCPVD/VSPD/
DU/LVDS device nodes and then describing the HDMI encoder connected to the LVDS
output (we're omitting the LVDS decoder for now). These patches depend on
the recent R8A77970 DU/LVDS and  on the R8A77970 PFC driver in order to work,
and R8A77970 PFC DT patches support patch in order to apply/compile/...

[1/5] arm64: dts: renesas: r8a77970: add FCPVD support
[2/5] arm64: dts: renesas: r8a77970: add VSPD support
[3/5] arm64: dts: renesas: r8a77970: add DU support
[4/5] arm64: dts: renesas: r8a77970: add LVDS support
[5/5] arm64: dts: renesas: v3msk: add DU/LVDS/HDMI support

WBR, Sergei
