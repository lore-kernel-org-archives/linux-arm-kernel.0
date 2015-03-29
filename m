From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 29 Mar 2015 23:26:11 +0200
Subject: [PATCH 2/2] ARM: dts: imx25-karo-tx25: Fix pincontrol definition
In-Reply-To: <20150325110902.GH32677@pengutronix.de>
References: <1427206147-19365-1-git-send-email-mpa@pengutronix.de>
 <1427206147-19365-2-git-send-email-mpa@pengutronix.de>
 <20150324195046.GU5664@pengutronix.de>
 <20150325110237.GB5024@pengutronix.de>
 <20150325110902.GH32677@pengutronix.de>
Message-ID: <20150329212611.GB25690@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 25, 2015 at 12:09:02PM +0100, Uwe Kleine-K?nig wrote:
> Hello Markus,
> 
> On Wed, Mar 25, 2015 at 12:02:37PM +0100, Markus Pargmann wrote:
> > On Tue, Mar 24, 2015 at 08:50:46PM +0100, Uwe Kleine-K?nig wrote:
> > > I think this grouping is a relict from the time when we considered to
> > > list the groups in the imx$num.dtsi? I would prefer to "fix" the driver
> > > to work with the way imx25-karo-tx25 presents the pinmuxing because I
> > > don't see the motivation for this extra grouping. (So let us define the
> > > current method of imx25-karo-tx25 as the good one to follow if you ask
> > > me.)
> > 
> > But the binding for the pinctrl unit is already defined. I am not sure
> > about the policy for changing devicetree bindings. I thought it should
> > be avoided?
> Allowing more valid definitions shouldn't be a problem, should it?
> So don't rip out parsing groups within a namespace, just complement it
> with support for namespace-less groups

I have posted a patch that allows parsing the pinctrl device node
without 'function' device nodes. So this patch can be dropped for the
moment.

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150329/77f56a13/attachment.sig>
