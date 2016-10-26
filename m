From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Oct 2016 11:07:43 +0100
Subject: [PATCH v7] spi: sun4i: Allow transfers larger than FIFO size
In-Reply-To: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
References: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
Message-ID: <20161026100743.GZ17252@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 12:00:30AM -0700, Alexandru Gagniuc wrote:
> This is the seventh attempt to get this patch in. I was prompted to look
> into this again as someone recently remarked:

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that 
any important information is recorded in the changelog rather than being
lost. 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161026/c5b06fb0/attachment.sig>
