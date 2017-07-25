From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Jul 2017 21:50:02 +0800
Subject: [PATCH 0/4] crypto: caam - add Job Ring support for DPAA2 parts
In-Reply-To: <VI1PR0401MB2591E386907CD8EA92DED08498B80@VI1PR0401MB2591.eurprd04.prod.outlook.com>
References: <20170718153050.15330-1-horia.geanta@nxp.com>
 <20170725132129.GB29754@dragon>
 <VI1PR0401MB2591E386907CD8EA92DED08498B80@VI1PR0401MB2591.eurprd04.prod.outlook.com>
Message-ID: <20170725135000.GC29754@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 01:31:52PM +0000, Horia Geant? wrote:
> On 7/25/2017 4:22 PM, Shawn Guo wrote:
> > On Tue, Jul 18, 2017 at 06:30:46PM +0300, Horia Geant? wrote:
> >> This patch set adds support for CAAM's legacy Job Ring backend / interface
> >> on platforms having DPAA2 (Datapath Acceleration Architecture v2), like
> >> LS1088A or LS2088A.
> >>
> >> I would like to get the DT patches through the crypto list (to make sure
> >> they don't end up merged before driver support).
> > 
> > Unless it's really urgent (usually critical bug fix), the DTS patches
> > should go through arm-soc tree.  We usually take DTS patches after the
> > driver counterpart has been accepted by subsystem maintainers, or in the
> > best case, has landed on mainline.
> 
> Thanks for the clarification.
> 
> Do I have to re-post the DTS patches once the driver is accepted or a
> ping should suffice or...?

A ping is sufficient.

Shawn
