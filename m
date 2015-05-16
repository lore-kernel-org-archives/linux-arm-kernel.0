From: pebolle@tiscali.nl (Paul Bolle)
Date: Sat, 16 May 2015 17:32:25 +0200
Subject: [PATCH v2 07/10] pinctrl: sunxi: Add H3 PIO controller support
In-Reply-To: <1431707940-19372-8-git-send-email-jenskuske@gmail.com>
References: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
 <1431707940-19372-8-git-send-email-jenskuske@gmail.com>
Message-ID: <1431790345.2341.37.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a nit: a license mismatch.

(I didn't bring this up in v1. Perhaps I should have.)

On Fri, 2015-05-15 at 18:38 +0200, Jens Kuske wrote:
> --- /dev/null
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c

> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

According to include/linux/module.h this states the license is GPL v2 or
later. So I think that either the comment at the top of this file or the
ident used in the MODULE_LICENSE() macro needs to change.


Paul Bolle
