From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Jun 2016 21:57:16 +0200
Subject: [PATCH v3 00/13] sunxi spi fixes
In-Reply-To: <cover.1465490774.git.hramrach@gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
Message-ID: <20160613195716.GD9354@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 05:46:48PM -0000, Michal Suchanek wrote:
> Hello,
> 
> This is update of the sunxi spi patches that should give full-featured SPI
> driver.
> 
> First three patches fix issues with the current driver and can be of use for
> stable kernels so adding cc for those.
> 
> I merged the sun4i and sun6i driver because there several issues that need to
> be fixed in both separately and they are even out of sync wrt some fixes.
> I guess some of the merge patches can be squashed.
> 
> I tested this with A10s Olinuxino Micro. I have no sun6i device so I cannot
> tell if that side was broken by this patchset - especially the last patch that
> adds DMA was afaik never tested on sun6i.

So, you didn't run that code through checkpatch and you rewrite the
whole thing entirely without even testing it... Awesome.

For the record, I'm still very much opposed to such a merge.

The first fixes are very welcome though, can and should go in.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/7904c14e/attachment.sig>
