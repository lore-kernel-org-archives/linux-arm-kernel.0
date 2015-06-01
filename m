From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 01 Jun 2015 23:31:48 +0200
Subject: [PATCH] fixup! dmaengine: pxa_dma: add debug information
In-Reply-To: <1432893073.29807.15.camel@perches.com> (Joe Perches's message of
 "Fri, 29 May 2015 02:51:13 -0700")
References: <1617548760.717381111.1432891749082.JavaMail.root@zimbra1-e1.priv.proxad.net>
 <1432893073.29807.15.camel@perches.com>
Message-ID: <87382bt8sb.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe Perches <joe@perches.com> writes:

> Hello Robert.
>
> The return value of that dbg_show_requester_chan function
> was incorrect and the increment of pos was an example of
> why the seq_printf return value was changed to void.
>
> It was a pretty common error and easy to understand given
> the expectation that seq_printf should work like printf.
Sure.

> It's a pity it bit you. but this type of patch collision
> should be a bit more difficult to reoccur in the future.

I got what I deserved. I knew it was coming, I've seen it in other drivers of
mine, but my left brain didn't tell the other half to crosscheck in this
patch. Anyway, it's not a big fixup, so everything is fine now.

Cheers.


-- 
Robert
