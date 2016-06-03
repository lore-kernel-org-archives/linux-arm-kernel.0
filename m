From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jun 2016 17:11:29 +0100
Subject: [PATCH v2 1/3] of: add common OF-based component functionality
In-Reply-To: <20160603154430.GA21013@ulmo.ba.sec>
References: <20160603141548.GC1041@n2100.armlinux.org.uk>
 <E1b8pyR-0005OJ-V3@rmk-PC.armlinux.org.uk>
 <20160603154430.GA21013@ulmo.ba.sec>
Message-ID: <20160603161129.GF1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 05:44:30PM +0200, Thierry Reding wrote:
> On Fri, Jun 03, 2016 at 03:21:19PM +0100, Russell King wrote:
> [...]
> > diff --git a/drivers/of/of_component.c b/drivers/of/of_component.c
> [...]
> > +static void component_compare_of(struct device *dev, void *data)
> > +{
> > +	return dev->of_node == data;
> > +}
> 
> The return statement here doesn't match the return value. Didn't GCC
> complain about this?

I didn't build-test it, because I wanted people's opinions on it first
(building means rebuilding my entire tree...)

Anyway, the patch series is dead because I'm not prepared to make the
changes which Rob mentioned, so we're back to v1 instead.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
