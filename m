From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2011 10:28:36 +0100
Subject: [PATCH 04/17] mach-versatile: retire custom LED code
In-Reply-To: <1309955687-19365-5-git-send-email-bryan.wu@canonical.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-5-git-send-email-bryan.wu@canonical.com>
Message-ID: <20110710092836.GT4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 08:34:34PM +0800, Bryan Wu wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The CPU activity LED is now handled by the trigger in the leds
> subsystem, retire this old CONFIG_LEDS-based code.

Shouldn't this be part of the previous patch?  The previous patch changes
both Realview and Versatile by touching plat-versatile.
