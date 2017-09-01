From: eric@anholt.net (Eric Anholt)
Date: Fri, 01 Sep 2017 11:31:07 -0700
Subject: [PATCH 6/7 v2] drm/pl111: Add optional variant display en/disable
 callbacks
In-Reply-To: <20170901093637.4041-7-linus.walleij@linaro.org>
References: <20170901093637.4041-1-linus.walleij@linaro.org>
 <20170901093637.4041-7-linus.walleij@linaro.org>
Message-ID: <87h8wml190.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> The silcon and components around the PL111 may require some

"silicon"

Other than that, while I'm still a little concerned about exposing too
many DRM formats on these boards, I think this is all worth landing at
this point.  Series is:

Reviewed-by: Eric Anholt <eric@anholt.net>

Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170901/0336215c/attachment.sig>
