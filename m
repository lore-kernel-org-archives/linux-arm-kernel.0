From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 21 Jan 2015 14:40:15 +0200
Subject: [PATCH 12/13] pinctrl: sh-pfc: sh7372: Remove PFC support
In-Reply-To: <20150121045457.7648.93743.sendpatchset@little-apple>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
 <20150121045457.7648.93743.sendpatchset@little-apple>
Message-ID: <1799633.8ThXAhsYET@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 January 2015 13:54:57 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Remove sh7372 PFC support as part of the sh7372 and Mackerel
> legacy code removal.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  drivers/pinctrl/sh-pfc/Kconfig      |    5
>  drivers/pinctrl/sh-pfc/Makefile     |    1
>  drivers/pinctrl/sh-pfc/core.c       |    9
>  drivers/pinctrl/sh-pfc/pfc-sh7372.c | 2645 --------------------------------
>  4 files changed, 2660 deletions(-)

There's a leftover reference to sh7372_pinmux_info in drivers/pinctrl/sh-
pfc/core.h.

Apart from that,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
