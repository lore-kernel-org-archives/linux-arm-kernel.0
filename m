From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 30 Aug 2016 11:54:42 +0300
Subject: [PATCH] video: ARM CLCD: fix up Integrator support
In-Reply-To: <1472462971-8935-1-git-send-email-linus.walleij@linaro.org>
References: <1472462971-8935-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <533a2463-daf2-be9c-491a-da7d6037728b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/08/16 12:29, Linus Walleij wrote:
> We need to mask all registers of the Integrator/CP core module
> control register, and actually write the calculated value to the
> control register, not the mask.
> 
> Tested on the Integrator/CP with RGB5551 VGA and works like a
> charm after this patch.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/video/fbdev/amba-clcd-versatile.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Thanks, queued for 4.9.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160830/b2b1d6df/attachment.sig>
