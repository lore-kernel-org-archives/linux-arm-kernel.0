From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 27 Aug 2018 09:48:16 +0800
Subject: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180802113552.GJ9117@sirena.org.uk>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
 <20180802113552.GJ9117@sirena.org.uk>
Message-ID: <20180827014815.GD29208@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2018 at 12:35:52PM +0100, Mark Brown wrote:
> On Thu, Aug 02, 2018 at 12:47:27PM +0200, Oleksij Rempel wrote:
> > On 02.08.2018 12:44, Mark Brown wrote:
> 
> > > I thought we'd got an ack for this from Raphael on a previous version or
> > > am I mistaken?
> 
> > No, we got an:
> > "Anyway, I have no particular problems with exporting
> > pm_power_off_prepare via EXPORT_SYMBOL_GPL()."
> 
> > Should i see it as ACK?

Mark,

Can you ACK on those two regulator patches, so that I can queue this
series up on IMX tree?

Shawn
