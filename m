From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 03 Jun 2016 17:10:32 +0200
Subject: [PATCH v2 2/3] drm: convert DT component matching to
 component_match_add_release()
In-Reply-To: <E1b8pyX-0005OP-2s@rmk-PC.armlinux.org.uk>
References: <20160603141548.GC1041@n2100.armlinux.org.uk>
 <E1b8pyX-0005OP-2s@rmk-PC.armlinux.org.uk>
Message-ID: <1464966632.32235.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 03.06.2016, 15:21 +0100 schrieb Russell King:
> Convert DT component matching to use component_match_add_release().
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/gpu/drm/arm/hdlcd_drv.c             |  9 +++------
>  drivers/gpu/drm/armada/armada_drv.c         |  8 ++------
>  drivers/gpu/drm/drm_of.c                    |  6 ++++--
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c       | 11 ++---------

For the etnaviv part:

Acked-by: Lucas Stach <l.stach@pengutronix.de>
