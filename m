From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 13 Jun 2018 23:09:33 +0300
Subject: [PATCH v3 0/2] Add R8A77980/Condor/V3HSK LVDS/HDMI support
Message-ID: <95d0db34-713d-8206-00c2-ee9a42aab823@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Here's the set of 5 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20180613-v4.17' tag and the Condor/V3HSK TD patches adding
Ethernet PHY IRQs. We're adding the R8A77980 FCPVD/VSPD/DU/LVDS device nodes
and then describing the LVDS decoder and HDMI encoder connected to the LVDS
output on the Condor and V3HSK boards.  These patches depend on the Thine
THC63LVD1024 driver and the R8A77980 LVDS support patch in order to work...

[1/2] arm64: dts: renesas: r8a77980: add FCPVD/VSPD/DU/LVDS support
[2/2] arm64: dts: renesas: condor/v3hsk: add DU/LVDS/HDMI support

WBR, Sergei
