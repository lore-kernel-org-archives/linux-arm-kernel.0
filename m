From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 21 Aug 2018 11:51:49 +0000
Subject: [PATCH V5 1/5] dt-bindings: arm: fsl: add scu binding doc
In-Reply-To: <AM0PR04MB4211B9113831B292110C709280310@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <1534781305-4770-2-git-send-email-aisheng.dong@nxp.com>
 <20180820181155.GA13901@bogus>
 <AM0PR04MB4211B9113831B292110C709280310@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <AM0PR04MB421175C894CFA5F16C2CB79C80310@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> > > +Clock bindings based on SCU Message Protocol
> > > +------------------------------------------------------------
> > > +
> > > +This binding uses the common clock binding[1].
> > > +
> > > +Required properties:
> > > +- compatible:		Should be "fsl,imx8qxp-clock".
> > > +- #clock-cells:		Should be 1. Contains the Clock ID value.
> >
> > There was a recent patch adding input clocks to other i.MX CCM bindings.
> > Is that needed here?
> >
> 
> Will double check it, thanks for reminder.

It should work for mx8 as well.

I will add them like below:
+- clocks:              List of clock specifiers, must contain an entry for
+                       each required entry in clock-names
+- clock-names:         Should include entries "xtal_32KHz", "xtal_24MHz"

Thanks for the suggestion.

Regards
Dong Aisheng
