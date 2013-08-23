From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 20:15:50 +0200
Subject: [patch] dmaengine: ste_dma40: off by one in d40_of_probe()
In-Reply-To: <20130823092343.GF31293@elgon.mountain>
References: <20130823092343.GF31293@elgon.mountain>
Message-ID: <CACRpkdbQs83Jm3t1N0+RwRATcipRAWsAWRCPwAcm6kO-oaVZUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 11:23 AM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:

> If "num_disabled" is equal to STEDMA40_MAX_PHYS (32) then we would write
> one space beyond the end of the pdata->disable_channels[] array.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
