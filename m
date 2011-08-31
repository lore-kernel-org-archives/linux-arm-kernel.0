From: khilman@ti.com (Kevin Hilman)
Date: Wed, 31 Aug 2011 15:31:12 -0700
Subject: [PATCH 7/7] OMAP2+: devices: Remove all omap_device_pm_latency
	structures
In-Reply-To: <1314026347-21623-8-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Mon, 22 Aug 2011 17:19:07 +0200")
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
	<1314026347-21623-8-git-send-email-b-cousson@ti.com>
Message-ID: <87sjoh6wnj.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> Remove all these duplicated structures since a default one is now
> available.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c    |   46 +++----------------------------------
>  arch/arm/mach-omap2/display.c    |   11 +--------
>  arch/arm/mach-omap2/dma.c        |   11 +--------
>  arch/arm/mach-omap2/gpio.c       |   12 +---------
>  arch/arm/mach-omap2/hsmmc.c      |   18 +--------------
>  arch/arm/mach-omap2/hwspinlock.c |   12 +---------
>  arch/arm/mach-omap2/mcbsp.c      |   11 +--------
>  arch/arm/mach-omap2/serial.c     |   25 +-------------------
>  arch/arm/mach-omap2/sr_device.c  |   11 +--------
>  arch/arm/mach-omap2/usb-musb.c   |   11 +--------
>  arch/arm/plat-omap/i2c.c         |   10 +-------
>  11 files changed, 14 insertions(+), 164 deletions(-)

Nice!  queuing this for v3.2 (branch: for_3.2/omap_device)

Kevin
