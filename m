From: gregkh@suse.de (Greg KH)
Date: Fri, 16 Sep 2011 15:43:00 +0200
Subject: [GIT PULL] Samsung Fixes for v3.1-rc7
In-Reply-To: <00cf01cc7466$e2cd66e0$a86834a0$%kim@samsung.com>
References: <00b101cc738d$bcf46ce0$36dd46a0$%kim@samsung.com>
	<201109151732.59886.arnd@arndb.de>
	<00cf01cc7466$e2cd66e0$a86834a0$%kim@samsung.com>
Message-ID: <20110916134300.GB16280@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 08:50:51PM +0900, Kukjin Kim wrote:
> Arnd Bergmann wrote:
> > 
> > On Thursday 15 September 2011, Kukjin Kim wrote:
> > > This is Samsung fixes for v3.1
> > >
> > > Please pull from:
> > >   git://github.com/kgene/linux-samsung.git samsung-fixes-2
> > > As you know, git.kernel.org/master.kernel.org has been down so I use
> > > temporary git repo. at github now.
> > >
> > > These things are needed for v3.1 and if any problems, please let me
> know.
> > >
> > > As a note, others for v3.2 will be sent in the next week...
> > 
> > Thanks, pulled.
> > 
> > Is it correct that you want none of these patches to be backported
> > into the stable or longterm releases? Some of these look like they
> > should be marked 'Cc: stable at kernel.org'.
> > 
> (Cc'ed Greg K-H)
> 
> Yes, you're right. Some patches are needed to sent to stable at kernel.org.
> But unfortunately, when they have been submitted, there was no 'Cc:
> stable at kernel.org'...

What do you mean?  Do you mean you just forgot to add them, or you
created them so long ago before there was a stable at kernel.org?

> In this case, I'm not sure which following method is proper...
> - to send 'pull request' to Greg / stable at kernel.org like bug fix during -rc
> - to submit each patches with adding 'Cc: stable at kernel.org' again
> - or ?

Are these in Linus's tree already?  If so, send me the git commit ids
and I will add them to the stable kernels.

If not, wait until they are, and then send me the git commit ids, and I
will then add them.

Before they get to Linus, there's nothing I can do with them, and I
don't accept pull requests as that makes no sense when it comes to the
stable kernel patch flow.

Does this help?

greg k-h
