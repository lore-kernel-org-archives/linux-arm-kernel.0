From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Oct 2016 12:14:19 +0100
Subject: [PATCH v7] spi: sun4i: Allow transfers larger than FIFO size
In-Reply-To: <20161026085528.vjjypbfmfbhvileb@lukather>
References: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
 <20161026085528.vjjypbfmfbhvileb@lukather>
Message-ID: <20161027111419.GK25322@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 10:55:28AM +0200, Maxime Ripard wrote:
> On Wed, Oct 26, 2016 at 12:00:30AM -0700, Alexandru Gagniuc wrote:

> > When DMA finally takes over, this fallback path is not mutually exclusive.

> I definitely agree, and we had this patch in the CHIP kernel for quite
> some time, working like a charm.

> I was planning to respin it in the next few days, glad to see you took
> care of it :)

> Mark, any comments on this? For the record, it already has my Acked-by.

Without knowing what the previous discussion was it's hard to comment,
it sounds like some prior review comments are just being ignored here
but since I'm not turning up anything with this subject line I've no
idea what that might have been (and that's very concerning in itself
given that this is apparently v7...).  I'm also concerned that there
isn't a version of this for sun6i, it's going to make all the
cut'n'pasting between the two drivers harder if we make changes in one
and not the other.

If the concern from the previous reviews to do with not using DMA is
there some reason it's hard to do DMA?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161027/279cec73/attachment.sig>
