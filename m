From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 9 Jul 2014 09:24:20 +0200
Subject: a case for a common efuse API?
In-Reply-To: <53BC4DD7.20906@codeaurora.org>
References: <53BC4DD7.20906@codeaurora.org>
Message-ID: <20140709072420.GI7827@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 08, 2014 at 01:00:23PM -0700, Stephen Boyd wrote:
> On MSM chips we have some efuses (called qfprom) where we store things
> like calibration data, speed bins, etc.
I don't have something constructive to say here, just want to point out
that on efm32 there is something similar. It's called "Device
Information (DI) Page" and contains "calibration values, a
unique identification number and other useful data".

Currently it is unused in mainline, but in my tree I access it directly
to determine cpu type (part number, part family number and Production
ID), flash and ram size, and the calibration settings for the ADC.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
