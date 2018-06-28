From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jun 2018 10:52:01 +0100
Subject: [PATCH 1/2] ARM: dts: armada388-clearfog: enable spi flash
In-Reply-To: <874lhn8dg1.fsf@bootlin.com>
References: <2bc87e3e365c460943730ded86c8fcb1ff55a533.1530170016.git.baruch@tkos.co.il>
 <874lhn8dg1.fsf@bootlin.com>
Message-ID: <20180628095201.GD17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 11:31:26AM +0200, Gregory CLEMENT wrote:
> Hi Baruch,
>  
>  On jeu., juin 28 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> 
> > The SolidRun Armada 388 SOM has the SPI flash populated by default
> > unless the customer explicitly asks otherwise. Enable support by
> > default.
> >
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> 
> Applied on mvebu/dt

It would be nice if you waited for acks or review before picking up
patches.  Only patch 2 has been acked and reviewed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
