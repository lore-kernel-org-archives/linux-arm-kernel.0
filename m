From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 16 Jul 2012 15:25:48 +0200
Subject: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <201207161506.08147.marex@denx.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <201207141409.38554.marex@denx.de>
 <20120716102151.GC17435@pengutronix.de>
 <201207161506.08147.marex@denx.de>
Message-ID: <20120716132548.GG17435@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > > > No, it doesn't. See above about small transfers. Consider the easy
> > > > > situation where you have sensor on one bus (so you do PIO because you
> > > > > transfer small data) and you have EEPROM on other bus, where you use
> > > > > DMA because you transfer large data. And the mixed mode isn't there
> > > > > yet.
> > > > 
> > > > I fully understand what you want to configure. I did before. Yet,
> > > > devicetree bindings are not platform_data and shouldn't be used like
> > > > them.
> > > 
> > > But then, how would you configure this detail on a per-bus basis? Well
> > > all
> > 
> > This is a question for devicetree-discuss.
> 
> Did you Cc it?

Well, I guess you already checked the mail headers and found out
yourself. The question behind the question probably is "Why didn't you
CC it?". The answer to that is that I didn't have much success by adding
it to $RANDOM_THREAD. It might be more efficient to answer starting a
new thread with explicit "[RFC] $THE_ISSUE". Since a conclusion there
won't make the next merge-window anyhow, I haven't done that now. That
put aside, it might be more efficient if someone with a bigger urge
might strive for a solution (yes, probably, but not necessarily you).
For me, it currently is just one task which needs to be scheduled
inbetween others.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120716/d049fd78/attachment.sig>
