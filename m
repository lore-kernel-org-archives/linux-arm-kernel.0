From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 08:35:48 -0500
Subject: [PATCH 1/5] ARM: Kirkwood: Convert NS2 to gpio-poweroff.
In-Reply-To: <1356704050-5047-1-git-send-email-andrew@lunn.ch>
References: <1356704050-5047-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130123133548.GK1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 28, 2012 at 03:14:10PM +0100, Andrew Lunn wrote:
> Remove C code and add a Device Tree node in its place.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> This is untested. I've been known to get the active hi/low the wrong
> way around so that the board powers off as the driver loads at boot
> time. So it would be very good to have a tested-by: sign off.
> 
> 
>  arch/arm/boot/dts/kirkwood-ns2-common.dtsi |    6 ++++++
>  arch/arm/mach-kirkwood/board-ns2.c         |   14 --------------
>  2 files changed, 6 insertions(+), 14 deletions(-)

Applied to mvebu/dt with a remove/remove resolution against Simon
Guinot's patch in mvebu/fixes:

  4ea931e ARM: Kirkwood: fix ns2 gpios by converting to pinctrl

thx,

Jason.
