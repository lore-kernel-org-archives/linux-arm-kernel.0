From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Sep 2010 10:03:17 +0100
Subject: [PATCH] ARM: remove legacy LEDS support from RealView and
	Versatile
In-Reply-To: <1284625415-8363-1-git-send-email-linus.walleij@stericsson.com>
References: <1284625415-8363-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100916090317.GB20197@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 10:23:35AM +0200, Linus Walleij wrote:
> We have merged proper support for the NEW_LEDS and LEDS_CLASS in
> the RealView and Versatile family in plat-versatile, including the
> heartbeat feature that was provided for these platforms so scrap
> this old LEDS stuff from these platforms.

Do we lose the display of activity across individual CPUs?
