From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Aug 2013 22:40:50 +0100
Subject: [PATCH 1/16 v2] sound/soc/pxa/mioa701_wm9713.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <1376340564-7975-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376340564-7975-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20130812214050.GI6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 10:49:24PM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
> arity of the called function.

What is the difference between this and the patch I applied the other
day?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130812/838d071a/attachment.sig>
