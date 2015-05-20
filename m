From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 May 2015 11:17:08 -0700
Subject: [PATCH] arm: dts: Beaglebone i2c definitions
In-Reply-To: <20150514153822.GJ15563@atomide.com>
References: <1431504274-32084-1-git-send-email-pantelis.antoniou@konsulko.com>
 <20150514153822.GJ15563@atomide.com>
Message-ID: <20150520181708.GL10274@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150514 08:40]:
> * Pantelis Antoniou <pantelis.antoniou@konsulko.com> [150513 01:05]:
> > The beaglebone family of boards contain two I2C busses enabled.
> > The first one with a baseboard identification EEPROM and a
> > cape I2C bus.
> 
> This seems safe to apply as the i2c2 pins are listed in the cape
> specification.
> 
> These pins could be used for other devices too.. But in that case
> the cape would not follow the cape standard.

So applying this one into omap-for-v4.2/dt thanks.

Tony
