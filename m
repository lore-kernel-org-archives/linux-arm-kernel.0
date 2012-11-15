From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 15 Nov 2012 18:05:57 +0000
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <1352650891-18356-2-git-send-email-andrew@lunn.ch>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
 <1352650891-18356-2-git-send-email-andrew@lunn.ch>
Message-ID: <20121115180557.924713E197F@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Nov 2012 17:21:29 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
> From: Jamie Lentin <jm@lentin.co.uk>
> 
> Given appropriate devicetree bindings, this driver registers a
> pm_power_off function to set a GPIO line high/low to power down
> your board.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/gpio/gpio-poweroff.txt     |   22 ++++
>  drivers/gpio/Kconfig                               |   10 ++
>  drivers/gpio/Makefile                              |    2 +
>  drivers/gpio/gpio-poweroff.c                       |  129 ++++++++++++++++++++

This isn't a gpio controller driver. Don't put it into drivers/gpio

g.
