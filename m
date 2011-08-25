From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Aug 2011 16:54:32 +0200
Subject: [PATCH] ARM: mx5: fix remaining unconsistent names for irqs
In-Reply-To: <1314276949-23062-1-git-send-email-hector.oron@gmail.com>
References: <CAODfWeFeaw2+xe01c5fiSr1tYsdM8J8ahZz8t-B7uuD+-P0GCQ@mail.gmail.com>
	<1314276949-23062-1-git-send-email-hector.oron@gmail.com>
Message-ID: <20110825145432.GY31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 01:55:49PM +0100, hector.oron at gmail.com wrote:
> From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> [hector: rebase on current Sascha's 'imx-features' branch]
> Signed-off-by: Hector Oron <hector.oron@gmail.com>
> ---
>  arch/arm/mach-mx5/clock-mx51-mx53.c   |    2 +-
>  arch/arm/mach-mx5/devices.c           |   10 +-
>  arch/arm/mach-mx5/mm.c                |    8 +-
>  arch/arm/plat-mxc/include/mach/mx51.h |  162 ++++++++++++++++----------------
>  4 files changed, 91 insertions(+), 91 deletions(-)

While merging together my feature branch with the cleanup branch I
realized that I already have this patch in the original version from
Uwe. Instead of adding this patch to the features branch I based
the feature branch on the cleanup branch. Sorry for letting you repost
this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
