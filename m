From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 May 2011 00:05:46 +0100
Subject: [PATCH 2/4] gpio: move Nomadik GPIO driver to drivers/gpio
In-Reply-To: <1306271221-28978-1-git-send-email-linus.walleij@stericsson.com>
References: <1306271221-28978-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110524230546.GC4652@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 11:07:01PM +0200, Linus Walleij wrote:
> -config NOMADIK_GPIO
> -	bool
> -	help
> -	  Support for the Nomadik GPIO controller.
> -

What about the statements which select this config symbol?
