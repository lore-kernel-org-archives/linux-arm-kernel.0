From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 28 Jun 2018 11:56:48 +0200
Subject: [PATCH 1/2] ARM: dts: armada388-clearfog: enable spi flash
In-Reply-To: <20180628095201.GD17271@n2100.armlinux.org.uk> (Russell King's
 message of "Thu, 28 Jun 2018 10:52:01 +0100")
References: <2bc87e3e365c460943730ded86c8fcb1ff55a533.1530170016.git.baruch@tkos.co.il>
 <874lhn8dg1.fsf@bootlin.com>
 <20180628095201.GD17271@n2100.armlinux.org.uk>
Message-ID: <87sh576xpb.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On jeu., juin 28 2018, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Thu, Jun 28, 2018 at 11:31:26AM +0200, Gregory CLEMENT wrote:
>> Hi Baruch,
>>  
>>  On jeu., juin 28 2018, Baruch Siach <baruch@tkos.co.il> wrote:
>> 
>> > The SolidRun Armada 388 SOM has the SPI flash populated by default
>> > unless the customer explicitly asks otherwise. Enable support by
>> > default.
>> >
>> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> 
>> Applied on mvebu/dt
>
> It would be nice if you waited for acks or review before picking up
> patches.  Only patch 2 has been acked and reviewed.

The mvebu branches can still be modified, they become immutably only
when we do PR, and usually it is around rc5 or rc6. So it's not too late
to make some remarks on them.

Gregory

>
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
