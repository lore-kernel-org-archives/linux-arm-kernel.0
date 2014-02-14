From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 14 Feb 2014 08:44:07 +0100
Subject: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
In-Reply-To: <20140213225248.GB15350@lukather>
References: <1391680285-16668-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391680285-16668-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140213082630.GA3119@katana> <20140213225248.GB15350@lukather>
Message-ID: <20140214074407.GA2569@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > For non-a10, That should be at least
> > 
> > 	compatible = "allwinner,sun4i-a13-i2c", "allwinner,sun4i-a10-i2c";
> > 
> > or
> > 
> > 	compatible = "allwinner,sun4i-a13-i2c", "allwinner,sun4i-i2c";
> > 
> > depending on the outcome above.
> > 
> > Or is my knowledge outdated already?
> > 
> 
> Since they are strictly compatible, we don't need to introduce any
> different compatible string here.

You never know all errata in advance. From what I know, one should
always use the specfic naming first, and then the generic fallback. So,
in case a distinction is needed later (think errata), then one doesn't
need to change the devicetrees.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140214/23f31104/attachment.sig>
