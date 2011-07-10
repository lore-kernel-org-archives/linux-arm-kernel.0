From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2011 10:33:06 +0100
Subject: [PATCH 08/17] mach-integrator: retire custom LED code
In-Reply-To: <1309955687-19365-9-git-send-email-bryan.wu@canonical.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-9-git-send-email-bryan.wu@canonical.com>
Message-ID: <20110710093306.GV4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 08:34:38PM +0800, Bryan Wu wrote:
> Use 4 LEDs in baseboard instead of the LED in core module.
> 
> The CPU activity LED is now handled by the trigger in the leds
> subsystem, retire this old CONFIG_LEDS-based code.

This is a functional change.  Integrator CP has four baseboard LEDs.
I don't remember Integrator AP having those, but it does have the LED
on the core module, which is used for CPU activity on all Integrator
platforms.
