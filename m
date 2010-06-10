From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 10 Jun 2010 11:18:44 +0200
Subject: [PATCH 0/3] MX25 watchdog
In-Reply-To: <cover.1276081393.git.baruch@tkos.co.il>
References: <cover.1276081393.git.baruch@tkos.co.il>
Message-ID: <20100610091844.GF5333@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 09, 2010 at 02:06:59PM +0300, Baruch Siach wrote:
> This series adds support for the new watchdog driver on the i.MX25 PDK 
> platform. A little fix to the watchdog driver itself is also added.
> 
> Baruch Siach (3):
>   mx25: add watchdog clock
>   mx25pdk: register watchdog device
>   imx2_wdt: fix section mismatch
> 
>  arch/arm/mach-mx25/clock.c        |    2 ++
>  arch/arm/mach-mx25/mach-mx25pdk.c |    1 +
>  drivers/watchdog/imx2_wdt.c       |    1 -
>  3 files changed, 3 insertions(+), 1 deletions(-)

Assuming the fixed register in patch 1, whole series is:

Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100610/f335e6bc/attachment.sig>
