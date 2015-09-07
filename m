From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Sep 2015 10:47:39 +0100
Subject: [PATCH 0/3] gpiolib: Initializing GPIOs using DT property
 gpio-initval
In-Reply-To: <1439979512-3894-1-git-send-email-mpa@pengutronix.de>
References: <1439979512-3894-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20150907094739.GR21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 12:18:29PM +0200, Markus Pargmann wrote:
> This series adds a gpio-initval property to the devicetree. It provides a way
> to initialize GPIOs to a defined value.

This is actually a good thing to have.  I know at least one SoC contains
a paragraph in its hardware spec:

General Purpose Pins (GPP)
Each individual pin can be defined as an input, output, or level interrupt
input. These pins can be used for indications retrieving or for peripherals
control. When not in use, program interface to GPIOs and set GPIOs as output.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
