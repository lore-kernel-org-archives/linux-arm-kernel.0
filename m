From: eric@anholt.net (Eric Anholt)
Date: Mon, 05 Mar 2018 16:34:44 -0800
Subject: [PATCH 3/4] drm/pl111: Handle the RealView variant separately
In-Reply-To: <20180302090948.6399-4-linus.walleij@linaro.org>
References: <20180302090948.6399-1-linus.walleij@linaro.org>
 <20180302090948.6399-4-linus.walleij@linaro.org>
Message-ID: <87vaeanisb.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> We want to cut down the default bpp to 16 on the RealView so
> we can have a 1024x768 framebuffer console by default. The
> memory bandwidth limitations makes this not work with the
> PL111 default of 32bpp.
>
> This builds on top of the earlier patches making the
> framebuffer default bpp a per-variant variable.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180305/0f62d6df/attachment.sig>
