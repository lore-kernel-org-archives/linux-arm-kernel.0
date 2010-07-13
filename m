From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Jul 2010 19:03:03 +0100
Subject: [PATCH v2 0/3] s3c24xx: iPAQ rx1950 series
In-Reply-To: <201007132005.50412.anarsoul@gmail.com>
References: <1278781069-30521-1-git-send-email-anarsoul@gmail.com>
	<201007131845.10426.anarsoul@gmail.com>
	<20100713155811.GA29710@sirena.org.uk>
	<201007132005.50412.anarsoul@gmail.com>
Message-ID: <20100713180303.GA9457@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 08:05:45PM +0300, Vasily Khoruzhick wrote:

> One more thing: on rx1950 (and on h1940) it's impossible to set blink 
> duty/period, is it really necessary to define blink_set callback in LEDs 
> driver instead of blinking on LED_HALF?

If an application tries to set the LED brightness but the LED actually
starts blinking that sounds bad...
