From: eric@anholt.net (Eric Anholt)
Date: Mon, 29 Jan 2018 15:39:22 -0800
Subject: [PATCH 1/4] drm/pl111: Error handling for CMA framebuffer
In-Reply-To: <20180126132033.19744-1-linus.walleij@linaro.org>
References: <20180126132033.19744-1-linus.walleij@linaro.org>
Message-ID: <874ln4xmj9.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> When attaching the CMA framebuffer we need to check for
> returned error pointers.

This doesn't seem to be necessary on drm-misc-next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180129/050edd86/attachment.sig>
