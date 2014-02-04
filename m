From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 18:49:09 +0000
Subject: [PATCH 00/17] amba: PM fixups for amba bus and some amba drivers
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140204184909.GT22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 04:58:41PM +0100, Ulf Hansson wrote:

> The fixes for the amba bus needs to be merged prior to the other, thus I think
> it could make sense to merge this complete patchset through Russell's tree,
> if he and the other maintainers think this is okay.

What are the actual dependencies for the SPI bit?  AFAICT it's probably
the first patch needs the bus updating?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/98dc336f/attachment-0001.sig>
