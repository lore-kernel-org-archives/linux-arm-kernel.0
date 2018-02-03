From: eric@anholt.net (Eric Anholt)
Date: Sat, 03 Feb 2018 15:44:26 -0800
Subject: [PATCH 4/5 v2] drm/pl111: Support variants with broken VBLANK
In-Reply-To: <20180201125513.5482-5-linus.walleij@linaro.org>
References: <20180201125513.5482-1-linus.walleij@linaro.org>
 <20180201125513.5482-5-linus.walleij@linaro.org>
Message-ID: <87efm1bput.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> The early Integrator CLCD synthesized in the Integrator CP and
> IM-PD1 FPGAs are broken: their vertical and next base interrupts
> are not functional. Support these variants by simply disabling
> the use of the vblank interrupt on these variants.

I do wonder if we just have the vblank interrupt number wrong or
something for Integrator.  However, let's get to at least functional
parity with fbdev before we worry too much about the new features that
DRM can bring us.

The remainder of this series is also:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180203/1d6c2089/attachment.sig>
