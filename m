From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 5 May 2014 08:51:13 -0700
Subject: [PATCH 0/6] ARM: sunxi: Machine code cleanup
In-Reply-To: <1399259284-6282-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399259284-6282-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140505155113.GB25199@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 04, 2014 at 10:07:58PM -0500, Maxime Ripard wrote:
> Hi,
> 
> This serie moves the restart code out of the mach-sunxi directory to
> either the watchdog driver or to a new driver in drivers/power/reset.
> 
> Since the reset code was pretty much all the code left in the
> mach-sunxi directory for all the SoCs but the A31, the only thing left
> into mach-sunxi are empty machine definition.
> 
Hi Maxime,

what changed in this version of the series compared to the previous
version ? Is it just the different directory for the reset driver ?

Thanks,
Guenter
