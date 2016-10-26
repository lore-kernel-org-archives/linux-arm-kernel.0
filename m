From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Oct 2016 10:55:28 +0200
Subject: [PATCH v7] spi: sun4i: Allow transfers larger than FIFO size
In-Reply-To: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
References: <1477465231-17704-1-git-send-email-mr.nuke.me@gmail.com>
Message-ID: <20161026085528.vjjypbfmfbhvileb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 12:00:30AM -0700, Alexandru Gagniuc wrote:
> This is the seventh attempt to get this patch in. I was prompted to look
> into this again as someone recently remarked:
> 
> " cool, to bad spi does not work properly on allwinner..."
> 
> Two and a half years ago,  we were told this will all be handled with DMA.
> A year or so ago, we were told this will all be handled with DMA.
> A week or so ago, we were told this will all be handled with DMA.
> 
> See the pattern?
> When DMA finally takes over, this fallback path is not mutually exclusive.

I definitely agree, and we had this patch in the CHIP kernel for quite
some time, working like a charm.

I was planning to respin it in the next few days, glad to see you took
care of it :)

Mark, any comments on this? For the record, it already has my Acked-by.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161026/f2bea18e/attachment.sig>
