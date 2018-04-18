From: eric@anholt.net (Eric Anholt)
Date: Wed, 18 Apr 2018 09:48:45 -0700
Subject: [PATCH 1/2 v3] drm/pl111: Support the Versatile Express
In-Reply-To: <20180418085242.19525-1-linus.walleij@linaro.org>
References: <20180418085242.19525-1-linus.walleij@linaro.org>
Message-ID: <87muy0latu.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> The Versatile Express uses a special configuration controller
> deeply embedded in the system motherboard FPGA to multiplex the
> two to three (!) display controller instances out to the single
> SiI9022 bridge.

With Robin's little fixes merged in, this is:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180418/ae7030ee/attachment-0001.sig>
