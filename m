From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Nov 2013 15:40:10 +0100
Subject: [PATCH] clk: add flags to distinguish xtal clocks
In-Reply-To: <1384243549.12583.36.camel@porter.coelho.fi>
References: <1382528150.21526.25.camel@porter.coelho.fi>
 <1383933648-28595-1-git-send-email-balbi@ti.com>
 <20131110113716.GN26440@lukather>
 <20131111194247.GB19212@saruman.home>
 <1384199456.12583.27.camel@porter.coelho.fi>
 <20131111205910.GA26440@lukather>
 <1384243549.12583.36.camel@porter.coelho.fi>
Message-ID: <20131113144010.GB3538@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 10:05:49AM +0200, Luca Coelho wrote:
> > What I'm not really convinced about is *how* you carry that metadata
> > in the DT, that's all, nothing more.
> 
> Okay, I get you.  My point is that being a crystal or not *is* a
> characteristic of the clock, so I think it could be part of the flags
> that describe it.

Yeah, but then, a crystal has a slightly different behaviour and
property than a oscillator, therefore the two aren't fully
"compatible" with each other.

> In any case, it's not really my call.  This is about the clock and it's
> not even my home turf (wireless). ;)
> 
> Thanks for your comments.  And I'm sorry if the tone of my previous
> email sounded harsh, it was not supposed to. :)

That's fine, don't worry :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131113/1233f854/attachment.sig>
