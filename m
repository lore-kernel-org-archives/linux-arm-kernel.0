From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Aug 2016 12:50:03 +0200
Subject: [PATCH 01/10] reset: ath79: add driver Kconfig option
In-Reply-To: <201608251826.2MYolse5%fengguang.wu@intel.com>
References: <201608251826.2MYolse5%fengguang.wu@intel.com>
Message-ID: <12166705.J71eyMyDGE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 25, 2016 6:31:48 PM CEST kbuild test robot wrote:
> 
>    drivers/reset/reset-ath79.c: In function 'ath79_reset_update':
> >> drivers/reset/reset-ath79.c:38:2: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
> >> drivers/reset/reset-ath79.c:43:2: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
>    cc1: some warnings being treated as errors
> 
> 

The file lacks "#include <linux/io.h"

	Arnd
