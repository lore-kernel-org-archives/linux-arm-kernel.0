From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Oct 2012 23:26:14 +0100
Subject: [PATCH] mvebu-gpio: Disable blinking when enabling a GPIO for
 output
In-Reply-To: <1351427004-32110-1-git-send-email-jm@lentin.co.uk>
References: <1351427004-32110-1-git-send-email-jm@lentin.co.uk>
Message-ID: <20121030232614.578c92e1@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sun, 28 Oct 2012 12:23:24 +0000, Jamie Lentin wrote:
> The plat-orion GPIO driver would disable any pin blinking whenever
> using a pin for output. Do the same here, as a blinking LED will
> continue to blink regardless of what the GPIO pin level is.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
