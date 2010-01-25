From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 24 Jan 2010 21:54:01 -0500 (EST)
Subject: [PATCH] mach-orion5x: D-link DNS-323 rev. B1 power-off
In-Reply-To: <953961.24356.qm@web39605.mail.mud.yahoo.com>
References: <953961.24356.qm@web39605.mail.mud.yahoo.com>
Message-ID: <alpine.LFD.2.00.1001242151060.1681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 24 Jan 2010, Erik Benada wrote:

> This patch fixes power LED blinking and power-off on DNS-323 rev. B1.
> 
> GPIO pin 3 has to be set to 1 to stop power LED blinking and to allow the LED to be controlled via leds-gpio. This pin has to be also set to 1 for power-off to work.
> To power-off the rev. B1 machine, pin 8 has to be set to 1 and then set to 0 to do actual power-off.
> 
> Tested on my DNS-323 rev. B1
> 
> Signed-off-by: Erik Benada <erikbenada@yahoo.ca>

What is this patch based on?  I get only rejects when trying to apply it.


Nicolas
