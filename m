From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 28 Jul 2011 01:34:52 +0200
Subject: [PULL] at91 init factorize
In-Reply-To: <201107271647.44015.arnd@arndb.de>
References: <20110727121156.GK10037@game.jcrosoft.org>
	<201107271647.44015.arnd@arndb.de>
Message-ID: <20110727233452.GN10037@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:47 Wed 27 Jul     , Arnd Bergmann wrote:
> On Wednesday 27 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >         This patch series factorize the init of the at91 soc and start the
> >         work to make the at91 capable to choose the soc at runtime instead of
> >         compile time.
> > 
> >         The next work will be to factorize the device resource registration
> >         and then switch to the device tree
> > 
> >         please pull
> > 
> > The following changes since commit e371d46ae45488bcb112a99a7de462e9e3aa6764:
> > 
> >   Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs-2.6 (2011-07-26 18:30:20 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://github.com/at91linux/linux-2.6-at91.git j/soc-detect
> 
> The patches look good, but come at an inconvenient time. We're still
> in the merge window, so I don't want to add stuff to linux-next yet
> that is destined for 3.2, and I have already sent out all the arm-soc
> patches for the 3.1 merge window, so I don't really want to send another
> round of patches at the last minute.
this are waiting ofr 2 release already

and was inthe next last release for more than 1 month

can we have them merge this time

Best Regards,
J.
