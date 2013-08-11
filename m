From: broonie@kernel.org (Mark Brown)
Date: Sun, 11 Aug 2013 19:06:48 +0100
Subject: [PATCH 1/16] sound/soc/pxa/mioa701_wm9713.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <1376239917-15594-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376239917-15594-2-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20130811180648.GA11327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 06:51:42PM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
> arity of the called function.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130811/0f269538/attachment.sig>
