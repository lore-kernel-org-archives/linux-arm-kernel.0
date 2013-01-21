From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 22:26:33 +0000
Subject: [PATCH 6/6] clocksource: update and move armada-370-xp-timer
 documentation to timer directory
In-Reply-To: <50FDBBB9.8090504@free-electrons.com>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <201301211822.54129.arnd@arndb.de> <50FDBBB9.8090504@free-electrons.com>
Message-ID: <201301212226.33736.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Gregory CLEMENT wrote:
> Hum, I am not sure they are different. From my point of view it is the same IP,
> but the one on Armada XP can use a 25MHz fix source clock. Apart from this,
> all the registers are the same. Moreover currently with this property we still have
> the possibility to not use the 25MHz clock source on Armada XP which is totally valid.
> The use of this source clock is not mandatory for the Armada XP SoCs.
> 
> For now I prefer to keep this property.

Ok, fair enough.

	Arnd
