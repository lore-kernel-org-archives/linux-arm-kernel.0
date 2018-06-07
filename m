From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 7 Jun 2018 23:17:03 +0300
Subject: [PATCH v2 0/5] Add R8A77980/Condor/V3HSK LVDS/HDMI support
Message-ID: <390fabf0-4caf-1600-3780-1893207d94f7@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 5 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180604-v4.17' tag. We're adding the R8A77980 FCPVD/VSPD/
DU/LVDS device nodes and then describing the LVDS decoder and HDMI encoder
connected to the LVDS output. These patches depend on the Thine THC63LVD1024
driver and the R8A77980 LVDS support patch in order to work, and R8A77980 GPIO
DT patches in order to apply/compile...

[1/5] arm64: dts: renesas: r8a77980: add FCPVD support
[2/5] arm64: dts: renesas: r8a77980: add VSPD support
[3/5] arm64: dts: renesas: r8a77980: add DU support
[4/5] arm64: dts: renesas: r8a77980: add LVDS support
[5/5] arm64: dts: renesas: condor/v3hsk: add DU/LVDS/HDMI support

WBR, Sergei
