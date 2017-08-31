From: eric@anholt.net (Eric Anholt)
Date: Thu, 31 Aug 2017 10:46:39 -0700
Subject: [PATCH 4/7] drm/pl111: Enable PL110 variant
In-Reply-To: <20170830180711.2791-5-linus.walleij@linaro.org>
References: <20170830180711.2791-1-linus.walleij@linaro.org>
 <20170830180711.2791-5-linus.walleij@linaro.org>
Message-ID: <87bmmvzl34.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> We detect and enable the use of the PL110 variant, an earlier
> incarnation of PL111. The only real difference is that the
> control and interrupt enable registers have swapped place.
> The Versatile AB and Versatile PB have a variant inbetween
> PL110 and PL111, it is PL110 but they have already swapped the
> two registers so those two need a bit of special handling.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

With the other Eric's little const fixes,

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170831/2778e092/attachment.sig>
