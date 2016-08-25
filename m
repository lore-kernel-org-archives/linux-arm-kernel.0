From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 25 Aug 2016 12:57:23 +0200
Subject: [PATCH 01/10] reset: ath79: add driver Kconfig option
In-Reply-To: <12166705.J71eyMyDGE@wuerfel>
References: <201608251826.2MYolse5%fengguang.wu@intel.com>
 <12166705.J71eyMyDGE@wuerfel>
Message-ID: <1472122643.3032.35.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 25.08.2016, 12:50 +0200 schrieb Arnd Bergmann:
> On Thursday, August 25, 2016 6:31:48 PM CEST kbuild test robot wrote:
> > 
> >    drivers/reset/reset-ath79.c: In function 'ath79_reset_update':
> > >> drivers/reset/reset-ath79.c:38:2: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
> > >> drivers/reset/reset-ath79.c:43:2: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
> >    cc1: some warnings being treated as errors
> > 
> > 
> 
> The file lacks "#include <linux/io.h"

I already sent the fix separately, should have included it with the
series.

regards
Philipp
