From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Wed, 16 Dec 2009 15:01:49 +0000
Subject: [PATCH] ARM: pxa/raumfeld: board support cleanups
In-Reply-To: <20091216144921.GT28375@buzzloop.caiaq.de>
References: <1260095301-29363-1-git-send-email-daniel@caiaq.de>
	<f17812d70912092008k67d37bcak73b774620fa3433a@mail.gmail.com>
	<f17812d70912160538m448fdcco238c3fc959c16a09@mail.gmail.com>
	<20091216144921.GT28375@buzzloop.caiaq.de>
Message-ID: <1260975709.3525.304.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-12-16 at 22:49 +0800, Daniel Mack wrote:
> On Wed, Dec 16, 2009 at 09:38:35PM +0800, Eric Miao wrote:
> > On Thu, Dec 10, 2009 at 12:08 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> > > On Sun, Dec 6, 2009 at 6:28 PM, Daniel Mack <daniel@caiaq.de> wrote:
> > >> Some minor things that I didn't notice in the original post.
> > >>
> > >> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > >> Cc: Eric Miao <eric.y.miao@gmail.com>
> > >
> > > Merged into 'pending'. Will be pushed out til max8660 stuffs are merged.
> > >
> > 
> > Daniel,
> > 
> > Do you know when will max8660 be merged? The window is about to
> > close, but nothing appear to be there about this max8660?
> 
> I don't know. The driver has been queued in regulator-2.6.git:
> 
>   http://git.kernel.org/?p=linux/kernel/git/broonie/regulator-2.6.git;a=commit;h=9c4d460f13b7d81abb26449a3920638889a3e5ed
> 
> Mark, Liam, any idea when things will hit the tree?

I'll be issuing a pull request tomorrow am.

Sorry about all this, there have been some "issues" lately with the twl
pmic rename that have slowed things down with regulator and mfd.

Liam
