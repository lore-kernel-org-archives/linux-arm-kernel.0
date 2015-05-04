From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 4 May 2015 15:26:47 +0200
Subject: [PATCH v2 2/7] crypto: add new driver for Marvell CESA
In-Reply-To: <1430742426-21202-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1430742426-21202-1-git-send-email-boris.brezillon@free-electrons.com>
 <1430742426-21202-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150504152647.7bd79751@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  4 May 2015 14:27:01 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

[...]

> +
> +#include "cesa.h"
> +
> +static int allhwsupport = !IS_ENABLED(CRYPTO_DEV_MV_CESA);

s/CRYPTO_DEV_MV_CESA/CONFIG_CRYPTO_DEV_MV_CESA/


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
