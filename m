From: horms@verge.net.au (Simon Horman)
Date: Mon, 11 Jun 2018 10:15:32 +0200
Subject: [PATCH v2 0/5] Add R8A77980/Condor/V3HSK LVDS/HDMI support
In-Reply-To: <4069170.tduNOXLj45@avalon>
References: <390fabf0-4caf-1600-3780-1893207d94f7@cogentembedded.com>
 <4069170.tduNOXLj45@avalon>
Message-ID: <20180611081531.xaax5ouvffnarhq5@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2018 at 05:27:19PM +0300, Laurent Pinchart wrote:
> Hi Sergei,
> 
> On Thursday, 7 June 2018 23:17:03 EEST Sergei Shtylyov wrote:
> > Hello!
> > 
> > Here's the set of 5 patches against Simon Horman's 'renesas.git' repo's
> > 'renesas-devel-20180604-v4.17' tag. We're adding the R8A77980 FCPVD/VSPD/
> > DU/LVDS device nodes and then describing the LVDS decoder and HDMI encoder
> > connected to the LVDS output. These patches depend on the Thine THC63LVD1024
> > driver and the R8A77980 LVDS support patch in order to work, and R8A77980
> > GPIO DT patches in order to apply/compile...
> > 
> > [1/5] arm64: dts: renesas: r8a77980: add FCPVD support
> > [2/5] arm64: dts: renesas: r8a77980: add VSPD support
> > [3/5] arm64: dts: renesas: r8a77980: add DU support
> > [4/5] arm64: dts: renesas: r8a77980: add LVDS support
> 
> Based on the recent request of the ARM SoC maintainers to avoid a plethora of 
> small patches, I think you can squash 1/5 to 4/5 all together.

Agreed.

Seregi could you please post a v2 with patches 1 - 4 squashed and the
register range for VSPD0 reduced to 0x5000? Thanks!

> > [5/5] arm64: dts: renesas: condor/v3hsk: add DU/LVDS/HDMI support
