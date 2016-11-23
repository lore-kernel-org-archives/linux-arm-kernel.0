From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Nov 2016 16:47:52 +0530
Subject: [PATCH 0/3] TI DA850/OMAP-L138/AM18x pinconf
In-Reply-To: <1479871767-20160-1-git-send-email-david@lechnology.com>
References: <1479871767-20160-1-git-send-email-david@lechnology.com>
Message-ID: <8c960321-708d-5e0d-2dbc-fb1ac5272bbc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 November 2016 08:59 AM, David Lechner wrote:
> This series adds a new driver and DT bindings for TI DA850/OMAP-L138/AM18x
> pinconf (bias pullup/pulldown).
> 
> The motivation for this series is LEGO MINDSTORMS EV3 support. It needs most,
> if not all, internal pullup/down resistors disabled in order to work correctly.

This looks really neat to my non-pinconf trained eyes. I have sent some
minor comments. But apart from that:

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

3/3 should go through my tree. If the driver patches are going to get
queued for v4.10, I can queue the DTS portion through my tree.

Thanks,
Sekhar
