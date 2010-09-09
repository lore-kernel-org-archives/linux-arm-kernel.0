From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 9 Sep 2010 09:29:43 +0100
Subject: Voltage/current/sensor monitoring interface and Wiegand
In-Reply-To: <20100909050137.GR14056@atomos.longlandclan.yi.org>
References: <20100909000245.GK14056@atomos.longlandclan.yi.org>
	<4C884AFA.20604@bluewatersys.com>
	<20100909050137.GR14056@atomos.longlandclan.yi.org>
Message-ID: <20100909082942.GA23903@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 09, 2010 at 03:01:37PM +1000, Stuart Longland wrote:

> Ahh okay, I'll have a look there..  The temperature isn't related to the
> power supply, so I might continue a searchfor its rightful place, but
> that class of devices seems like a good fit.

hwmon might be useful also (you can expose the same data via both
interfaces if you like).
