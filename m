From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Sep 2016 16:08:28 +0200
Subject: [GIT PULL] LPC18xx DTS changes for v4.9
In-Reply-To: <20160827143311.7303-1-manabian@gmail.com>
References: <20160827143311.7303-1-manabian@gmail.com>
Message-ID: <3137023.v3bZUhM49v@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, August 27, 2016 4:33:11 PM CEST Joachim Eastwood wrote:
> Device Tree additions for LPC18xx platform
> 
> Small fix for the compatible string for the NXP SE97 I2C chip on the
> Hitex Eval board from Guenter and a couple of additional DT properties
> for the DWMAC that is need for correct operation.

Pulled into next/dt, thanks!

Sorry for not having looked at it earlier, I would probably have suggested
to apply both as a bugfix for v4.8, but if you didn't consider them
urgent enough then, it's probably not worth bothering now.

	Arnd
