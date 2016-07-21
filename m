From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Jul 2016 19:15:45 +0100
Subject: [PATCH v6] ARM: sun4i: spi: Allow transfers larger than FIFO size
In-Reply-To: <34E27D10-C620-4288-A1A8-489B75D4757B@schinagl.nl>
References: <1439062912-4405-1-git-send-email-oliver@schinagl.nl>
 <20160721112701.GB6610@weiser.dinsnail.net>
 <20160721163153.GO6509@sirena.org.uk>
 <20160721172712.GA10640@weiser.dinsnail.net>
 <34E27D10-C620-4288-A1A8-489B75D4757B@schinagl.nl>
Message-ID: <20160721181545.GP6509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 08:03:16PM +0200, Olliver Schinagl wrote:
> As i recall, some claimed it was needed as we have dma now, but i think this patch still scratches the same itch ...

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160721/f0f1a2d4/attachment.sig>
