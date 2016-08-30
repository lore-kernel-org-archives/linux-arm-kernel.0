From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Aug 2016 14:53:56 +0200
Subject: [PATCH] drm/sun4i: rgb: add missing calls to
 drm_panel_{prepare,unprepare}
In-Reply-To: <20160830065500.31847-1-net147@gmail.com>
References: <20160830065500.31847-1-net147@gmail.com>
Message-ID: <20160830125356.GE18605@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 30, 2016 at 04:55:00PM +1000, Jonathan Liu wrote:
> If the enable-gpios property of a simple panel in device tree is set,
> the GPIO is not toggled on/off because of missing calls to
> drm_panel_prepare and drm_panel_unprepare.
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>

This was not applying properly, but I merged it.

Please make sure that it applies on top of the current next branch.

Good catch, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160830/f006f93f/attachment.sig>
