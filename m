From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 6 Mar 2018 10:34:37 +0100
Subject: [PATCH 0/7] media: sun6i: Various fixes and improvements
In-Reply-To: <20180305183535.b75ec79199efc3cacefc49c2@magewell.com>
References: <1519697113-32202-1-git-send-email-yong.deng@magewell.com>
 <20180305093535.11801-1-maxime.ripard@bootlin.com>
 <20180305183535.b75ec79199efc3cacefc49c2@magewell.com>
Message-ID: <20180306093437.5etrtg63bvzey3ue@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 06:35:35PM +0800, Yong wrote:
> > Hi Yong,
> > 
> > Here are a bunch of patches I came up with after testing your last
> > (v8) version of the CSI patches.
> > 
> > There's some improvements (patches 1 and 7) and fixes for
> > regressions found in the v8 compared to the v7 (patches 2, 3, 4 and
> > 5), and one fix that we discussed for the signals polarity for the
> > parallel interface (patch 6).
> > 
> > Feel free to squash them in your serie for the v9.
> 
> OK. Thank you!
> 
> I notice that your responses have not been listed in google group
> since February.

Yeah, I know, apparently I can't change my email address in google
groups, or unsubscribe, so I'm not subscribed with my new mail, which
means I can't post either.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180306/2f0660be/attachment.sig>
