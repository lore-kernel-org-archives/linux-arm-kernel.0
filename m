From: ivan.kuten@promwad.com (Ivan Kuten)
Date: Sat, 17 Jul 2010 15:37:39 +0300
Subject: [PATCH 1/2] MISC: driver for the character LCD found in ARM
	refdesigns
In-Reply-To: <1279365780-18462-1-git-send-email-triad@df.lth.se>
References: <1279365780-18462-1-git-send-email-triad@df.lth.se>
Message-ID: <4C41A413.50205@promwad.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hello Linus,

> diff --git a/drivers/misc/arm-charlcd.c b/drivers/misc/arm-charlcd.c
> new file mode 100644
> index 0000000..9e3879e
> --- /dev/null
> +++ b/drivers/misc/arm-charlcd.c
> @@ -0,0 +1,396 @@
> +/*
> + * Driver for the on-board character LCD found on some ARM reference boards
> + * This is basically an Hitachi HD44780 LCD with a custom IP block to drive it
> + * http://en.wikipedia.org/wiki/HD44780_Character_LCD
> + * Currently it will just display the text "ARM Linux" and the linux version
> + *
> + * License terms: GNU General Public License (GPL) version 2
> + * Author: Linus Walleij<triad@df.lth.se>
> + */

Any chance to sync your efforts with lcd-linux project (http://lcd-linux.sourceforge.net/) ?
They seems to have a support for HD44780 LCD controller. Mattia, project maintainer is on CC 
copy.

Best regards,
Ivan Kuten
-----------------------------------------------------------
Head of Embedded Software Department

Promwad Innovation Company

22, Olshevskogo St.,

220073, Minsk,

BELARUS

Phone/Fax: +375 (17) 312-1246

Skype: vanokuten

Web: www.promwad.com
