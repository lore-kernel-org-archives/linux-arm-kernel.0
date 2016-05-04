From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 May 2016 17:43:06 +0100
Subject: [alsa-devel] [PATCH 1/7] ASoC: mediatek: Refine mt8173 driver
 and change config option
In-Reply-To: <1461934848-60011-2-git-send-email-garlic.tseng@mediatek.com>
References: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
 <1461934848-60011-2-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <20160504164306.GA6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 09:00:42PM +0800, Garlic Tseng wrote:

>  .../{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c}     | 488 ++++++++++-----------

So there's going to be no code sharing at all between this and any other
Mediatek chips?  That seems very surprising, it'd suggest that the
hardware designers were creating a new design completely from scratch
each time which doesn't seem all that likely.  This is an unusual way of
organizing things and we need a much clearer explanation of what's going
on here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160504/c512c785/attachment.sig>
