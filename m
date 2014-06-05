From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jun 2014 19:36:15 +0100
Subject: MMC is *still* broken...
Message-ID: <20140605183615.GG23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/mmc/core/core.c: In function 'mmc_card_power_up':
drivers/mmc/core/core.c:1517:4: error: implicit declaration of function 'gpiod_set_value'

I reported this back in April, and it's still present.  This makes me
wonder if MMC is maintained.... and makes me wonder what the point
of reporting bugs is if they just get ignored.

The config file which produced that is:

http://www.arm.linux.org.uk/developer/build/file.php?lid=8820

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
