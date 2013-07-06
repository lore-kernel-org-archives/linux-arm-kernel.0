From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 6 Jul 2013 21:55:26 +0200
Subject: MTD EEPROM support and driver integration
In-Reply-To: <8997501.Dchyii8uWX@wuerfel>
References: <20130705201118.GM2959@lukather> <5811519.oHVuMujf0I@wuerfel>
 <20130706120112.GA11069@lukather> <8997501.Dchyii8uWX@wuerfel>
Message-ID: <20130706215526.7fc3e191@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 06 Jul 2013 21:06:49 +0200, Arnd Bergmann wrote:
> On Saturday 06 July 2013 14:01:12 Maxime Ripard wrote:
> > So that leave us with mainly one path to achieve this goal:
> >   - Add a regmap-mtd backend
> >   - Add DT parsing code for regmap
> >   - Move the EEPROM drivers from misc to mtd
> 
> Yes, I think that would be good. For the last step, we definitely need
> buy-in from Wolfgand and Jean, as they are maintaining the current eeprom
> drivers.

I am maintaining the legacy eeprom driver, which nobody should be using
in conjunction with DT. So you don't need my approval for anything.

-- 
Jean Delvare
