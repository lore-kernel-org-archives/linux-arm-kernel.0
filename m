From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 5 Mar 2015 19:40:44 +0100
Subject: [PATCH v2 1/4] i2c: sunxi: Add Reduced Serial Bus (RSB) support
In-Reply-To: <20150305182817.GB4911@lukather>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
 <1425284686-5116-2-git-send-email-wens@csie.org>
 <20150304172710.GA884@katana> <20150305182817.GB4911@lukather>
Message-ID: <20150305184044.GA881@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > I don't have the bandwidth for a full review right now. However, I
> > already wanted to tell you guys that my gut feeling is that this
> > protocol is quite far away from I2C. P2WI was already at the edge.
> > Maybe there is a better place for such custom stuff? I dunno yet.
> 
> That's unfortunate, especially since it looks closer to SPI than what
> P2WI even was.

SPI? I assume you mean I2C. Can you elaborate your reasoning?

> What would be your suggestion?

Let me quote:

"I don't have the bandwidth for a full review right now... I dunno
yet."
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150305/977c183b/attachment.sig>
