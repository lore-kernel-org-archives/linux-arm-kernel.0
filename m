From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 6 Jun 2018 19:51:55 +0300
Subject: [PATCH 0/5] Add R8A77970/V3MSK LVDS/HDMI support
Message-ID: <9c092022-dcdd-1320-499c-00c5b2d9db3b@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 5 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180604-v4.17-rc7' tag. We're adding the R8A77980 FCPVD/VSPD/
DU/LVDS device nodes and then describing the LVDS decoder and HDMI encoder
connected to the LVDS output. These patches depend on the Thine THC63LVD1024
driver and the R8A77980 LVDS support patch in order to work, and R8A77980 GPIO
DT patches in order to apply/compile...

[1/5] arm64: dts: renesas: r8a77980: add FCPVD support
[2/5] arm64: dts: renesas: r8a77980: add VSPD support
[3/5] arm64: dts: renesas: r8a77980: add DU support
[4/5] arm64: dts: renesas: r8a77980: add LVDS support
[5/5] arm64: dts: renesas: condor: add DU/LVDS/HDMI support

WBR, Sergei
