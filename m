From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 06 Aug 2018 08:29:16 +0200
Subject: [PATCH v3 01/10] drm/atomic: Add __drm_atomic_helper_plane_reset
In-Reply-To: <20180804161530.12275-2-alexandru-cosmin.gheorghe@arm.com>
References: <20180804161530.12275-1-alexandru-cosmin.gheorghe@arm.com>
 <20180804161530.12275-2-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <1533536956.4204.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-08-04 at 17:15 +0100, Alexandru Gheorghe wrote:
> There are a lot of drivers that subclass drm_plane_state, all of them
> duplicate the code that links together the plane with plane_state.
> 
> On top of that, drivers that enable core properties also have to
> duplicate the code for initializing the properties to their default
> values, which in all cases are the same as the defaults from core.
> 
> Change since v1:
> - Make it consistent with the other helpers and require that both
>   plane and state not be NULL, suggested by Boris Brezillon and
>   Philipp Zabel.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
