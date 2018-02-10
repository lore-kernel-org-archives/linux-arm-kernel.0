From: eric@anholt.net (Eric Anholt)
Date: Sat, 10 Feb 2018 17:10:30 +0000
Subject: [PATCH 2/3] drm/pl111: Make the default BPP a per-variant variable
In-Reply-To: <20180206121854.4407-3-linus.walleij@linaro.org>
References: <20180206121854.4407-1-linus.walleij@linaro.org>
 <20180206121854.4407-3-linus.walleij@linaro.org>
Message-ID: <878tc0db3t.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> The PL110, Integrator and Versatile boards strongly prefer to
> use 16 BPP even if other modes are supported, both to keep down
> memory consumption and also to easier find a good match to
> supported resolutions with consideration taken to the memory
> bandwidth of the platforms.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This seems like a reasonable compromise in complexity to get the default
fb up.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180210/332a7256/attachment-0001.sig>
