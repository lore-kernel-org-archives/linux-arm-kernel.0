From: eric@anholt.net (Eric Anholt)
Date: Thu, 21 Jun 2018 13:00:41 -0700
Subject: [PATCH] drm/pl111: Support Nomadik LCDC variant
In-Reply-To: <20180621184450.25377-1-linus.walleij@linaro.org>
References: <20180621184450.25377-1-linus.walleij@linaro.org>
Message-ID: <87lgb79afq.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> The Nomadik has a variant of the PL110 known as "Color LCD
> Controller" LCDC. This variant has the same bit ordering as
> the DRM subsystem (in difference from the other variants)
> and adds a few bits for the control of 5551, 565 etc in the
> control register. Notably it also adds a packed RGB888
> 24BPP mode.
>
> We add support by detecting this variant and also adding a
> small plug-in that will mux the LCDC out if the ASIC happens
> to be muxed to the other graphics controller (they are
> mutually exclusive).

This all looks reasonable to me.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180621/3739e435/attachment.sig>
