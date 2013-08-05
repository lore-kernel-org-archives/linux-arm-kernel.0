From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 5 Aug 2013 08:52:48 -0400
Subject: [GIT PULL] ARM: mvebu: fixes-non-critical for v3.12
In-Reply-To: <20130804202300.GB15602@quad.lixom.net>
References: <20130725174132.GO23879@titan.lakedaemon.net>
 <20130804202300.GB15602@quad.lixom.net>
Message-ID: <20130805125248.GG19280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 01:23:00PM -0700, Olof Johansson wrote:
> On Thu, Jul 25, 2013 at 01:41:32PM -0400, Jason Cooper wrote:
> > 
> > The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
> > 
> >   Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/linux-mvebu.git tags/fixes-non-3.12
> 
> Hi Jason,
> 
> I pulled this, but I was wondering if you'd mind holding back on basing your
> branches on the very latest -rc all the time, and instead go almost as far back
> as you can without merge conflicts? In particular for those who have trivial
> contents such as these.
> 
> Main reason is to avoid bringing in new -rcs in the next/* branches too often,
> since there's _usually_ not a need for it.

No problem.  Thanks for bringing it to my attention.  Do you want me to
rebase my other branches (including mvebu/boards)?

> Of course, the opposite condition tends to frustrate me too, i.e. if someone
> sends a pull request for the merge window that conflicts with fixes they've
> already sent that has gone in. So please watch out for that. :)

Sounds reasonable, I usually track that anyway.  In most situations,
though, I would just merge in mvebu/fixes to get the needed fix.  In
those scenarios, basing on -rc1 should be fine.  Only when a fix goes
through Russell's tree would it make sense to base off of the -rcX
containing the fix.

So, "Not too hot, not too cold, porridge that's just right" :-P

thx,

Jason.
