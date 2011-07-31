From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 31 Jul 2011 05:44:17 +0200
Subject: [PULL] at91 init factorize
In-Reply-To: <alpine.LFD.2.00.1107301434160.12766@xanadu.home>
References: <20110727121156.GK10037@game.jcrosoft.org>
	<201107271647.44015.arnd@arndb.de>
	<20110727233452.GN10037@game.jcrosoft.org>
	<201107281758.27738.arnd@arndb.de>
	<20110730074623.GG25658@game.jcrosoft.org>
	<alpine.LFD.2.00.1107301434160.12766@xanadu.home>
Message-ID: <20110731034417.GA6255@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:39 Sat 30 Jul     , Nicolas Pitre wrote:
> On Sat, 30 Jul 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > On 17:58 Thu 28 Jul     , Arnd Bergmann wrote:
> > > On Thursday 28 July 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > The patches look good, but come at an inconvenient time. We're still
> > > > > in the merge window, so I don't want to add stuff to linux-next yet
> > > > > that is destined for 3.2, and I have already sent out all the arm-soc
> > > > > patches for the 3.1 merge window, so I don't really want to send another
> > > > > round of patches at the last minute.
> > > > this are waiting ofr 2 release already
> > > > 
> > > > and was inthe next last release for more than 1 month
> > > > 
> > > > can we have them merge this time
> > > 
> > > What I don't understand at all is why you are waiting instead of sending
> > > a pull request for all that time then. I've repeatedly given announcements
> > > about the state of the arm-soc tree and asked people to send patches
> > > they want in 3.1, and you actually sent bug fixes that way earlier
> > > 
> > > You've had more than enough time before the merge window, and would even
> > > have made an exception if you had sent your stuff a few hours earlier,
> > > before I sent everything to Linus.
> > > Also, the branch you sent me was created on the same day, meaning that
> > > it can't possibly have had a lot of testing (though it looks harmless
> > > enough). When you send a pull request, the patches should always be
> > > based on an -rc or main release to simplify the merge history, and
> > > it's better not to rebase to the latest one if you already have the
> > > patches.
> > sorry but those patch are 4 motnhs old and yes I rebase the branch to the
> > current linus tree before send the pull request.
> 
> Please don't do that.  It is best if you keep the same branch content 
> identical to what has been tested and validated for a while.
except I send time to retest it
> 
> > so as the merge is still open and the patches was in the next for more than
> > one month there no reason to do not pull them for this relese
> 
> Yes there is a reason: you were invited to submit that pull request much 
> sooner i.e. _before_ the merge window opened.  Why didn't you do it a 
> month ago?
work on other cleanup for this merge but can not finish them in time

so this work can go other work are pending as they depend on it

let this pull go and theere was no announch that we can not send pull during
the merge windows so if there is such rule we must write a patch and put it in
the ARM tree to specified the ARM merge window otherwise the merge normal
merge window prime

Best Regards,
J.
