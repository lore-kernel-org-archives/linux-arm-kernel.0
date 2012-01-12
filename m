From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 12 Jan 2012 03:04:21 +0000
Subject: [PATCH 06/11] ep93xx: Don't use system controller defines in
 audio drivers
In-Reply-To: <4F0DE9B7.60201@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-7-git-send-email-rmallon@gmail.com>
 <20120111174216.GD24213@opensource.wolfsonmicro.com>
 <4F0DE9B7.60201@gmail.com>
Message-ID: <20120112030420.GB22775@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 06:57:43AM +1100, Ryan Mallon wrote:

> We can either add a second function, like ep93xx_i2s_acquire_on_ssp, or
> we can create a set of defines for the various options needed. I just
> want to avoid exposing the system controller registers/flags directly.
> The ep93xx chip is now obsolete, so I don't expect new boards to appear,
> and these two boards have been the only ones with audio support for a
> couple of years now, so this seemed to be the best solution.

OK, that seems reasonable - I've applied the change, thanks.
