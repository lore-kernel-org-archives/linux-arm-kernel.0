From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Aug 2016 00:43:25 +0100
Subject: "Failed to create /dev/root: -14" after commit e6978e4bf1 ("ARM:
 save and reset the address limit when entering an exception")
In-Reply-To: <CAOi56cUMzOVzcOOwW433YH1hsyiSTHofgQP5a1ghaTu94fL01w@mail.gmail.com>
References: <57A15C41.6000804@roeck-us.net>
 <20160803083822.GI1041@n2100.armlinux.org.uk>
 <57A20896.30300@roeck-us.net>
 <20160804100748.GP1041@n2100.armlinux.org.uk>
 <87eg5y3rsk.fsf@free-electrons.com>
 <CAOi56cUMzOVzcOOwW433YH1hsyiSTHofgQP5a1ghaTu94fL01w@mail.gmail.com>
Message-ID: <20160810234325.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 06:34:22PM -0500, Kevin Hilman wrote:
> I also tested this fixes the boot issue on Armada XP.
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>

It should be in the current linux-next.  I'll send them on in the
usual way over the weekend for -rc2, with your ack for this one.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
