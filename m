From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 Oct 2013 08:46:55 +0200
Subject: [Patch v2][ 11/37] staging: imx-drm: use of_get_display_timings.
In-Reply-To: <1382022155-21954-12-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-12-git-send-email-denis@eukrea.com>
Message-ID: <20131018064655.GS30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 05:02:09PM +0200, Denis Carikli wrote:
> The comment on top of of_get_drm_display_mode says:
>  * This function is expensive and should only be used, if only one mode is to be
>  * read from DT. To get multiple modes start with of_get_display_timings and
>  * work with that instead.

This patch seems to add support for multiple displays at the parallel
display port. How does this work? You can only connect one display at a
time.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
