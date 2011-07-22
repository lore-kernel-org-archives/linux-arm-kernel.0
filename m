From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 22 Jul 2011 20:28:08 +0200
Subject: [PATCH 7/7] at91sam9/wdt: move register header to drivers
In-Reply-To: <1310687525-22486-7-git-send-email-plagnioj@jcrosoft.com>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
	<1310687525-22486-7-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20110722182808.GD31767@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: linux-watchdog at vger.kernel.org
> ---
>  drivers/watchdog/at91sam9_wdt.c                    |    2 +-
>  .../at91_wdt.h => drivers/watchdog/at91sam9_wdt.h  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename arch/arm/mach-at91/include/mach/at91_wdt.h => drivers/watchdog/at91sam9_wdt.h (96%)

Added this patch to the linux-2.6-watchdog-next tree.

Kind regards,
Wim.
