From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 May 2015 22:16:38 +0100
Subject: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
In-Reply-To: <20150521210411.GA5406@deathray>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
 <20150512191758.GX3066@sirena.org.uk>
 <20150521020709.GA14258@deathray>
 <20150521101857.GR21577@sirena.org.uk>
 <20150521210411.GA5406@deathray>
Message-ID: <20150521211638.GN21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 04:04:11PM -0500, Michael Welling wrote:

> Do you want to revert the patch and apply a new one or should I provide a
> patch that reverts the changes and fixes it all in one?

Can you please send me separate revert and re-add patches, that's
probably going to be easier to review.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150521/cb6d4ebe/attachment.sig>
