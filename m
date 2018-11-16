From: greenfoo@gluegarage.com (Fernando)
Date: Fri, 16 Nov 2018 18:04:44 +0100
Subject: [PATCH 3/9] drm: replace "drm_dev_unref" function with
 "drm_dev_put"
In-Reply-To: <1542363310.23489.22.camel@pengutronix.de>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-4-greenfoo@gluegarage.com>
 <1542363310.23489.22.camel@pengutronix.de>
Message-ID: <1542387884.1134874.1579436592.07F916C5@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018, at 11:15 AM, Lucas Stach wrote:
> Am Donnerstag, den 15.11.2018, 23:16 +0100 schrieb Fernando Ramos:
> > This patch unifies the naming of DRM functions for reference counting as
> > requested on Documentation/gpu/todo.rst
> > 
> > > Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
> > ---
> > ?drivers/gpu/drm/arc/arcpgu_drv.c?????????????| 4 ++--
> > ?drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++--
> > ?drivers/gpu/drm/etnaviv/etnaviv_drv.c????????| 4 ++--
> 
> At least the etnaviv part of the patch is already fixed in linux-next.
> 
> Regards,
> Lucas
 

Thanks for the notice.

I'm new on this, how should I proceed? Should I create a new (V2) patch series with these changes reverted? Or will the maintainer automatically take care of this when merging?

And, related to this, what is the "good" branch to start developing new drm patches? Is is "drm-next" or "linux-next"? Or does it change depending on how much time until the merge window closes?

Thanks!
