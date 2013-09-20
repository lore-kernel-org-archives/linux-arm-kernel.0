From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri, 20 Sep 2013 23:58:15 +0300
Subject: [PATCH 0/8] IOP GPIO refactoring take 2
In-Reply-To: <1379708226-7802-1-git-send-email-linus.walleij@linaro.org>
References: <1379708226-7802-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130920205815.GF30568@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 20, 2013 at 10:17:06PM +0200, Linus Walleij wrote:
> Testing and ACKing appreciated.

I think it looks good now. I applied the patches 1-8 on top of 3.12-rc1,
and Thecus N2100 boots fine and pressing the power button restarts the
system as expected. So for the whole series:

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks,

A.
