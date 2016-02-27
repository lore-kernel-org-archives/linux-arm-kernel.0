From: broonie@kernel.org (Mark Brown)
Date: Sat, 27 Feb 2016 11:03:06 +0900
Subject: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
In-Reply-To: <87k2lruqsw.fsf@belgarion.home>
References: <20160220171459.GA18327@sirena.org.uk>
 <871t87z1gz.fsf@belgarion.home>
 <20160220195925.GF18327@sirena.org.uk>
 <87twl3xgud.fsf@belgarion.home>
 <20160220211659.GG18327@sirena.org.uk>
 <878u2fxbp9.fsf@belgarion.home>
 <20160221014920.GK18327@sirena.org.uk>
 <87povkuuf6.fsf@belgarion.home>
 <20160226023021.GH18327@sirena.org.uk>
 <87k2lruqsw.fsf@belgarion.home>
Message-ID: <20160227020306.GW18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 10:04:15PM +0100, Robert Jarzmik wrote:

> Ok, let me think about it and propose something, an approach.

> I must admit I like the structure I saw in drivers/amba/bus.c, ie. to have
> something like :

...

> Well, if I'm totally mistaken, tell me. If not it will take me a bit of time to
> write is down properly in a Documentation/ file.

That seems pretty reasonable at first pass I think, the main issue is
just managing the transition safely for all the users.  There's a lot of
fragility in the AC'97 hardware and software so people have been very
reluctant to touch it.  Equally I think a lot of the more problematic
users probably aren't in use any more so you can probably get away with
more now than would have been the case in the past.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160227/52f997b6/attachment-0001.sig>
