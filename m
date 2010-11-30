From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 1 Dec 2010 09:55:30 +1100
Subject: Please include ux500 core into linux-next
In-Reply-To: <AANLkTi=fXAucNc-m9dqb0cgA6mGJ5c4cXC-pTOz05vwY@mail.gmail.com>
References: <AANLkTi=fXAucNc-m9dqb0cgA6mGJ5c4cXC-pTOz05vwY@mail.gmail.com>
Message-ID: <20101201095530.af394617.sfr@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, 30 Nov 2010 10:31:43 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:
>
> please consider to start merging our ux500-core branch into
> linux-next:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> Branch: ux500-core
> 
> (NB: there is a "next" branch, which include patches to multiple
> subsystems, don't merge that, this is just the ux500 core.)

OK.

> I rebase this regularly to Torvalds' -rc tags, hope that's OK.

Yeah, that's OK.  Rebasing to tags is better than random points, but less
rebasing is even better.

> All code is being reviewed on the linux-arm-kernel list, and the
> patches here are intended for pull request to Russell King who
> in turn take them upstream. I hope this procedure is
> acceptable.

This is all fine.  Russell, I am assuming that this is all OK with you.

> We currently have some of these patches in Russells patch tracker
> as well, but they will be taken out in favor of the pull approach
> once this branch lands in -next.

I have added that branch from today with just you (Linus) as the
contact.  If you want additional contacts (people who will be notified of
merge and build problems), please let me know.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr at canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101201/feb7ca87/attachment.sig>
