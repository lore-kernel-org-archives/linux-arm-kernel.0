From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Mar 2011 10:53:15 +0100
Subject: [PATCH 04/10] ux500: Adding sdi support on snowball.
In-Reply-To: <1299884892-6766-5-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
	<1299884892-6766-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <201103121053.15526.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 00:08:06 mathieu.poirier at linaro.org wrote:
> @@ -36,7 +36,7 @@
>  
>  #include "ste-dma40-db8500.h"
>  #include "devices-db8500.h"
> -#include "board-snowball.h"
> +#include "board-mop500.h"
>  #include "board-mop500-regulators.h"

Is this change intentional? I'd assume you still want both headers
included here.

	Arnd
