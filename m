From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Aug 2015 14:13:59 +0100
Subject: [PATCH 2/4] ASoc: rockchip: Add rockchip SPDIF transceiver driver
In-Reply-To: <1438159908.5106.32.camel@tiscali.nl>
References: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438085011-16577-3-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438159908.5106.32.camel@tiscali.nl>
Message-ID: <20150807131359.GA8892@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 10:51:48AM +0200, Paul Bolle wrote:

> > +		.name = DRV_NAME,
> > +		.of_match_table = of_match_ptr(rockchip_spdif_match),
> > +		.pm = &rockchip_spdif_pm_ops,
> > +	},
> > +};
> > +module_platform_driver(rockchip_spdif_driver);

> > +MODULE_ALIAS("platform:" DRV_NAME);

> (I seem to remember that Mark Brown is OK with this, at least for the
> time being, but for future reference I'll ask the question anyway.) Is
> there a corresponding struct platform_device with a "rockchip-spdif"
> .name? Because if there's no such platform_device I think this line
> doesn't really do anything for this driver.

Paul, you've been told this before but please stop providing these
review comments.  It has been explained to you repeatedly that we do not
require any form of machine definition to be merged to merge a driver,
please pay attention to those explanations and stop sending the same
bogus feedback to patch submitters.  This just creates confusion for the
submitters and wastes everyone's time.  

If you have questions the way to raise them is to respond to the
original discussions, not to send new replies to other submitters
repeating the same feedback you were previously advised was incorrect.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150807/a24111b4/attachment.sig>
