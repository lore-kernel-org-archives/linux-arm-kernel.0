From: eric@anholt.net (Eric Anholt)
Date: Wed, 18 Apr 2018 09:45:15 -0700
Subject: [PATCH 2/2 v3] drm/pl111: Enable device-specific assigned memory
In-Reply-To: <20180418085242.19525-2-linus.walleij@linaro.org>
References: <20180418085242.19525-1-linus.walleij@linaro.org>
 <20180418085242.19525-2-linus.walleij@linaro.org>
Message-ID: <87po2wlazo.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> The Versatile Express has 8 MB of dedicated video RAM (VRAM)
> on the motherboard, which is what we should be using for the
> PL111 if available. On this platform, the memory backplane
> is constructed so that only this memory will work properly
> with the CLCD on the motherboard, using any other memory
> area just gives random snow on the display.
>
> The CA9 Versatile Express also has a PL111 instance on its
> core tile that can address all memory, and this does not
> have the restriction.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180418/c35055a9/attachment.sig>
