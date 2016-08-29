From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 14:34:48 +0800
Subject: [Patch v4 9/9] arm64: Update device tree for Layerscape SoCs
In-Reply-To: <20160812091354.GB333@nazgul.tnic>
References: <1470780000-16750-1-git-send-email-york.sun@nxp.com>
 <20160812091354.GB333@nazgul.tnic>
Message-ID: <20160829063448.GA32489@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2016 at 11:13:54AM +0200, Borislav Petkov wrote:
> On Tue, Aug 09, 2016 at 02:59:39PM -0700, York Sun wrote:
> > Add DDR memory controller nodes to enable EDAC driver.
> > 
> > Signed-off-by: York Sun <york.sun@nxp.com>
> > 
> > ---
> > Change log
> >   v4: no change
> >   v3: no change
> >   v2: no change
> > 
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  7 +++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 14 ++++++++++++++
> >  2 files changed, 21 insertions(+)
> 
> This needs an ACK from DT people.

Is it mandatory to have DTS changes go with driver part altogether?
Otherwise, I prefer to have them go through separate tree.

Shawn
