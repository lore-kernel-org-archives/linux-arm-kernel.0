From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 16:50:14 -0800
Subject: [GIT PULL 4/5] drop unused omap platform_data for v4.10
In-Reply-To: <582b7c9c.5790620a.e95a2.d669SMTPIN_ADDED_BROKEN@mx.google.com>
References: <pull-1479236877-351747>
 <582b7c9c.5790620a.e95a2.d669SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20161119005014.GG15902@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 01:22:22PM -0800, Tony Lindgren wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/legacy-signed
> 
> for you to fetch changes up to 19944b3a4a30163656b26e9d2ca659657113ac3e:
> 
>   ARM: OMAP2+: Drop legacy sdram timings (2016-11-10 16:07:32 -0700)
> 
> ----------------------------------------------------------------
> Legacy platform_data removal for omaps for v4.10 merge window.
> We've dropped the last legacy boot board-*.c files for mach-omap2
> for v4.9 so now we can start removing the unused platform_data.
> 
> All of the below has been unused since v4.9 merge window:
> 
> - Drop legacy pmic init code
> 
> - Apply seq_puts() fixes for legacy mux code, then drop it
> 
> - Drop legacy serial init
> 
> - Drop legacy i2c init
> 
> - Drop legacy PM init
> 
> - Drop legacy twl4030 platform init
> 
> - Drop legacy USB host init
> 
> - Drop legacy muxing for tusb6010, n8x0 is still using it's
>   platform init via pdata-quirks.c
> 
> - Drop legacy musb init
> 
> - Drop hwmod related legacy mux code
> 
> - Drop legacy hwmod data for omap3
> 
> - Drop legacy smsc911x and smc91x init
> 
> - Drop legacy board flash init
> 
> - Drop legacy ads7846 init
> 
> - Drop legacy sdram timings

[...]

>  45 files changed, 160 insertions(+), 8306 deletions(-)

Nice!!


Merged into next/soc, since we don't really track a cleanup branch any more.


-Olof
