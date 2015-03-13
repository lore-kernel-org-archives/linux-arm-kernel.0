From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 13 Mar 2015 10:35:15 +0100
Subject: [PATCH resend v4] phy: Add driver to support individual USB
 PHYs on sun9i
In-Reply-To: <1426154079-423-1-git-send-email-wens@csie.org>
References: <1426154079-423-1-git-send-email-wens@csie.org>
Message-ID: <1426239315.5304.57.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just a license nit.

On Thu, 2015-03-12 at 17:54 +0800, Chen-Yu Tsai wrote:
> --- /dev/null
> +++ b/drivers/phy/phy-sun9i-usb.c

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

This states that the license is GPL v2 or later.

> +MODULE_LICENSE("GPL v2");

And it's
    MODULE_LICENSE("GPL");

that matches that statement.


Paul Bolle
