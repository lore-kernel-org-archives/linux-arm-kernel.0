From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 12 Dec 2011 10:33:01 +1100
Subject: Adding remoteproc/rpmsg to linux-next
In-Reply-To: <CAK=WgbaU6vpiBGSgogYPjQNmrF-U0wk1rSXMX83DdgQa9hw5Mw@mail.gmail.com>
References: <CAK=WgbaU6vpiBGSgogYPjQNmrF-U0wk1rSXMX83DdgQa9hw5Mw@mail.gmail.com>
Message-ID: <20111212103301.5ff6a582dca82394ace40e8d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

On Fri, 9 Dec 2011 16:55:27 +0200 Ohad Ben-Cohen <ohad@wizery.com> wrote:
>
> Can you please add the following remoteproc tree to linux-next ?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git for-next

I have added that from today.

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
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111212/4151c18b/attachment.sig>
