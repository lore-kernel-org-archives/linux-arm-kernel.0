From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 17 Jul 2018 04:51:34 +0000
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: add mu binding doc
In-Reply-To: <20180716151654.GA21819@rob-hp-laptop>
References: <20180716114209.25242-1-o.rempel@pengutronix.de>
 <20180716114209.25242-2-o.rempel@pengutronix.de>
 <20180716151654.GA21819@rob-hp-laptop>
Message-ID: <AM0PR04MB42115331D2201A6A07D82CEA805C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Monday, July 16, 2018 11:17 PM
> To: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>; Fabio Estevam
> <fabio.estevam@nxp.com>; Mark Rutland <mark.rutland@arm.com>; A.s.
> Dong <aisheng.dong@nxp.com>; kernel at pengutronix.de; linux-arm-
> kernel at lists.infradead.org; devicetree at vger.kernel.org; dl-linux-imx <linux-
> imx at nxp.com>
> Subject: Re: [PATCH v3 1/3] dt-bindings: arm: fsl: add mu binding doc
> 
> On Mon, Jul 16, 2018 at 01:42:07PM +0200, Oleksij Rempel wrote:
> > The Messaging Unit module enables two processors within the SoC to
> > communicate and coordinate by passing messages (e.g. data, status and
> > control) through the MU interface.
> 
> v3? I already gave my R-by on v4 from Dong. Please coordinate your work on
> this.

Okay.

Oleksij, 
could you re-add the M4 support part in a separate patch based on
the already acked SCU one?
I guess you can re-send with the acked one.

Regards
Dong Aisheng

> 
> >
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  .../devicetree/bindings/mailbox/fsl,mu.txt    | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mailbox/fsl,mu.txt
