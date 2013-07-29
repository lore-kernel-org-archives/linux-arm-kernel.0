From: pavel@denx.de (Pavel Machek)
Date: Mon, 29 Jul 2013 20:25:54 +0200
Subject: [PATCH 1/2] ARM: dts: Change dw-apb-timer-osc and
 dw-apb-timer-sp to just dw-apb-timer
In-Reply-To: <1374723797-22169-1-git-send-email-dinguyen@altera.com>
References: <1374723797-22169-1-git-send-email-dinguyen@altera.com>
Message-ID: <20130729182554.GA10346@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2013-07-24 22:43:16, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> "dw-apb-timer-osc" and "dw-apb-timer-sp" are the same implementation of the
> DW APB timer, just fed by different clocks.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> CC: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> CC: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> CC: Jamie Iles <jamie@jamieiles.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>

Looks good to me, thanks!
									Pavel

Reviewed-by: Pavel Machek <pavel@denx.de>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
