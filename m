From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 May 2014 20:26:32 +0200
Subject: [RFC PATCH 0/5] watchdog: Add reboot API
In-Reply-To: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
References: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
Message-ID: <201405052026.32666.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 May 2014, Guenter Roeck wrote:
> 
> Some hardware implements reboot through its watchdog hardware, for example
> by triggering a watchdog timeout or by writing into its watchdog register
> set. Platform specific code starts to spread into watchdog drivers,
> typically by setting pointers to a callback function which is then called
> from the architecture's reset handler.

Looks very nice to me, thanks for starting this!

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
