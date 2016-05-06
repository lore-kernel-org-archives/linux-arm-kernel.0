From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 May 2016 13:20:46 +0100
Subject: [alsa-devel] [PATCH 1/7] ASoC: mediatek: Refine mt8173 driver
 and change config option
In-Reply-To: <1462444772.2873.70.camel@mtksdaap41>
References: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
 <1461934848-60011-2-git-send-email-garlic.tseng@mediatek.com>
 <20160504164306.GA6292@sirena.org.uk>
 <1462416342.25179.36.camel@mtksdaap41> <572B0511.80701@gmail.com>
 <1462444772.2873.70.camel@mtksdaap41>
Message-ID: <20160506122046.GR6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2016 at 06:39:32PM +0800, Garlic Tseng wrote:

> As mentioned above, the difference of the ASoCs between the two chips
> are too large that we have a hard time sharing the driver code.

The things you're describing all sound like scaling differences rather
than fundamental changes.  I'd expect to see at least some shared code
here, we don't want to be just duplicating the entire driver every time
there's a new hardware revision.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160506/56dfd93d/attachment.sig>
