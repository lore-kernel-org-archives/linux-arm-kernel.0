From: tj@kernel.org (Tejun Heo)
Date: Wed, 19 Feb 2014 10:36:24 -0500
Subject: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
In-Reply-To: <20140219152336.GH10504@lee--X1>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
 <20140218233645.GP31892@mtj.dyndns.org>
 <20140219083025.GB10504@lee--X1>
 <20140219140458.GA10134@htj.dyndns.org>
 <20140219150121.GG10504@lee--X1>
 <20140219150654.GH10134@htj.dyndns.org>
 <20140219152336.GH10504@lee--X1>
Message-ID: <20140219153624.GI10134@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 03:23:36PM +0000, Lee Jones wrote:
> Since when has maintaining core code been the responsibility of the
> leaf driver developers? If you're aware that the core code is
> sub-standard then it's you who should be fixing it.

No, there isn't this clear divide between core and the leaf
developers.  People working on the "core" don't just grow off the
ground.  You can't just go around piling mess around claiming that
it's not your responsbility and then expect someone else to clean up
after you.  How can that be *possibly* sustainable?

> I think it's great that forward thinking developers like Hans take on
> challenges to improve subsystems which are lacking in one way or

Yeah, which happened only because I pushed back and Hans isn't even
paid to do it.  Doesn't that say something?  Nobody is actually
helping Hans' work.  Not at all, nada, zilch.  Just complain when
directed towards it.

> another, but holding back other development while this process is
> ongoing is fundamentally wrong. Especially in this case where you're
> still actively reviewing/NACKing the core changes.
> 
> Changes to APIs should either support backward-capability or change all
> effected drivers. I haven't been able to apply the patches yet, so I
> can't tell which one of these holds true, but I believe it's the
> former. In which case any new driver using the _current_ (not old)
> API should fold neatly in. I've even offered to convert to the new API
> once it's Mainlined. How can I say fairer than that?
> 
> Finally, do try and stay at least a little bit professional on the
> MLs. That sort of disrespectful, rude behaviour may be how you guys do
> it at Redhat, but most will think it's nothing more than childish.

If you want me to be respectful towards you, don't be a crybaby
screaming "it's not fair".  It apparently isn't clear to you that you
have to chip in for the whole thing to be maintainable in the long
term.  Unfair... lol, that was a good one, really.

-- 
tejun
