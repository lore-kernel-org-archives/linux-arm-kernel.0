From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Aug 2013 19:14:55 +0100
Subject: [PATCH 12/29] sound/soc/samsung/ac97.c: simplify use of
 devm_ioremap_resource
In-Reply-To: <1376471493-22215-13-git-send-email-Julia.Lawall@lip6.fr>
References: <1376471493-22215-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376471493-22215-13-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20130814181455.GH2401@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 11:11:16AM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Remove unneeded error handling on the result of a call to
> platform_get_resource when the value is passed to devm_ioremap_resource.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130814/ded7bb4e/attachment-0001.sig>
