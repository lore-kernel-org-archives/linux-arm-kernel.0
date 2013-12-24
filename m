From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 24 Dec 2013 09:31:07 +0100
Subject: [PATCH] MAINTAINERS: ARM: SiRF: add sirf UART and watchdog to
 maintain list
In-Reply-To: <1387807431-3547-1-git-send-email-21cnbao@gmail.com>
References: <1387807431-3547-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20131224083107.GB10158@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 10:03:51PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> take CSR serial and watchdog drivers into maintain list.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  MAINTAINERS |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d5e4ff3..b9a1173 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -858,6 +858,8 @@ F:	drivers/mmc/host/sdhci-sirf.c
>  F:	drivers/pinctrl/sirf/
>  F:	drivers/rtc/rtc-sirfsoc.c
>  F:	drivers/spi/spi-sirf.c
> +F:	drivers/tty/serial/sirfsoc_uart.*
> +F:	drivers/watchdog/sirfsoc_wdt.c
Maybe just use

N: sirf

and AFAIK you should Cc: affected maintainers and optimally get their
ack.

Best regards and Merry Christmas
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
