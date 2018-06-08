From: horms@verge.net.au (Simon Horman)
Date: Fri, 8 Jun 2018 10:21:25 +0200
Subject: [PATCH v2 0/5] Add R8A77980/Condor/V3HSK LVDS/HDMI support
In-Reply-To: <390fabf0-4caf-1600-3780-1893207d94f7@cogentembedded.com>
References: <390fabf0-4caf-1600-3780-1893207d94f7@cogentembedded.com>
Message-ID: <20180608082125.tjnd6jayecv26csv@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2018 at 11:17:03PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> Here's the set of 5 patches against Simon Horman's 'renesas.git' repo's
> 'renesas-devel-20180604-v4.17' tag. We're adding the R8A77980 FCPVD/VSPD/
> DU/LVDS device nodes and then describing the LVDS decoder and HDMI encoder
> connected to the LVDS output. These patches depend on the Thine THC63LVD1024
> driver and the R8A77980 LVDS support patch in order to work, and R8A77980 GPIO
> DT patches in order to apply/compile...
> 
> [1/5] arm64: dts: renesas: r8a77980: add FCPVD support
> [2/5] arm64: dts: renesas: r8a77980: add VSPD support
> [3/5] arm64: dts: renesas: r8a77980: add DU support
> [4/5] arm64: dts: renesas: r8a77980: add LVDS support
> [5/5] arm64: dts: renesas: condor/v3hsk: add DU/LVDS/HDMI support

Sergei,

what are the changes in this series between v1 and v2?
