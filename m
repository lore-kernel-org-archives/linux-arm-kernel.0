From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 11 Mar 2011 15:49:53 +0200
Subject: [PATCH v2 0/2] OMAP: Overo: Add gpio-leds and gpio-keys support
In-Reply-To: <1299715686-3920-1-git-send-email-steve@sakoman.com>
References: <1299715686-3920-1-git-send-email-steve@sakoman.com>
Message-ID: <1299851393.2479.12.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-09 at 18:08 -0600, Steve Sakoman wrote:
> Overo COMs and expansion boards have three LEDS and 2 push button switches
> connected to GPIO pins.  This patch series adds support for utilizing
> them with gpio-keys and gpio-leds.
> 
> Changes from version 1: Guard gpio_leds assignment with CONFIG_LEDS_GPIO check
> 
> Steve Sakoman (2):
>   OMAP: Add gpio-leds support for Overo
>   OMAP: Add gpio-keys support for Overo
> 
>  arch/arm/mach-omap2/board-overo.c |   95 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 95 insertions(+), 0 deletions(-)
> 

Thanks, I'll take these to my tree.

 Tomi
