From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 25 Mar 2015 12:09:02 +0100
Subject: [PATCH 2/2] ARM: dts: imx25-karo-tx25: Fix pincontrol definition
In-Reply-To: <20150325110237.GB5024@pengutronix.de>
References: <1427206147-19365-1-git-send-email-mpa@pengutronix.de>
 <1427206147-19365-2-git-send-email-mpa@pengutronix.de>
 <20150324195046.GU5664@pengutronix.de>
 <20150325110237.GB5024@pengutronix.de>
Message-ID: <20150325110902.GH32677@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Markus,

On Wed, Mar 25, 2015 at 12:02:37PM +0100, Markus Pargmann wrote:
> On Tue, Mar 24, 2015 at 08:50:46PM +0100, Uwe Kleine-K?nig wrote:
> > I think this grouping is a relict from the time when we considered to
> > list the groups in the imx$num.dtsi? I would prefer to "fix" the driver
> > to work with the way imx25-karo-tx25 presents the pinmuxing because I
> > don't see the motivation for this extra grouping. (So let us define the
> > current method of imx25-karo-tx25 as the good one to follow if you ask
> > me.)
> 
> But the binding for the pinctrl unit is already defined. I am not sure
> about the policy for changing devicetree bindings. I thought it should
> be avoided?
Allowing more valid definitions shouldn't be a problem, should it?
So don't rip out parsing groups within a namespace, just complement it
with support for namespace-less groups

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
