From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Aug 2015 09:53:16 -0700
Subject: [PATCH 1/3] spi: mediatek: revise coding style
In-Reply-To: <1439955478-2733-2-git-send-email-leilk.liu@mediatek.com>
References: <1439955478-2733-1-git-send-email-leilk.liu@mediatek.com>
 <1439955478-2733-2-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20150819165316.GU10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 11:37:56AM +0800, Leilk Liu wrote:
> This patch revises mediatek spi driver coding styles.

Two problems here.  One is that it's best practice to make purely
stylistic changes after any substantial ones, that way people can pick
up bug fixes without needing the stylistic changes.  The other is that
this just isn't an adequate changelog - what are the revisions that are
being made to the coding style and why are they being made?  This is a
very large change and there seem to be many different and unrelated
changes being made here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150819/946a63f0/attachment-0001.sig>
