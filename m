From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 May 2010 15:29:46 +0100
Subject: pxa-devel back-merge / cherry pick request
In-Reply-To: <AANLkTikMrOtrwI82Y9sXEGU80TZJ7brruXuoE8wiUGLj@mail.gmail.com>
References: <20100531114815.GF2695@buzzloop.caiaq.de>
	<AANLkTikMrOtrwI82Y9sXEGU80TZJ7brruXuoE8wiUGLj@mail.gmail.com>
Message-ID: <20100531142946.GB30051@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 31, 2010 at 09:25:07PM +0800, Eric Miao wrote:
> On Mon, May 31, 2010 at 7:48 PM, Daniel Mack <daniel@caiaq.de> wrote:
> > Hi Eric,
> >
> > Is there any plans to merge Linus' tree into your pxa-devel any time
> > soon? I'm asking because I have one patch pending which depends on
> >
> > ?a3bcbbee ("pda_power: Add function callbacks for suspend and resume")
> >
> > upstream. Alternatively, could you cherry-pick this one commit?
> >
> 
> 'devel' branch rebased and pushed. Normally I rebase before sending
> git pull request to Russell.

It's best to avoid rebasing altogether unless there is a good reason
to do so.

If you want to make a decision about whether to rebase, one way to do
it is to create a test branch/tree, and try merging your selected
rebase point in - if it conflicts then you know when the original
branch is merged it'll have problems.
