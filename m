From: spk.linux@gmail.com (Sachin Kamat)
Date: Tue, 8 Jul 2014 20:50:13 +0530
Subject: [PATCH 1/3] ARM: exynos: remove unused <mach/memory.h>
In-Reply-To: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAK5sBcF_kLbky_88ZR1xTUWj5PsrZrzx7hEC=chqP72QpqP5ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 3:27 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> ARCH_EXYNOS doesn't select NEED_MACH_MEMORY_H, so <asm/memory.h> doesn't
> include <mach/memory.h> and so this file is not used and can go away.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---

Reviewed-by: Sachin Kamat <sachin.kamat@samsung.com>

Tested on Arndale octa board (Exynos 5420).

 Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
-- 
Regards,
Sachin.
