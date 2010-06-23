From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 24 Jun 2010 09:52:33 +1000
Subject: [GIT PULL linux-next] Samsung S5P SoCs
In-Reply-To: <000d01cb126e$fa193690$ee4ba3b0$%kim@samsung.com>
References: <000d01cb126e$fa193690$ee4ba3b0$%kim@samsung.com>
Message-ID: <20100624095233.d2daaa4f.sfr@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 23 Jun 2010 09:56:52 +0900 Kukjin Kim <kgene.kim@samsung.com> wrote:
>
> Could you please pull the following into linux-next?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git#for-ne
> xt
> 
> This tree is for next- Samsung S5P SoCs such as S5P6440, S5P6442, S5PC100,
> and S5PV210/S5PC110.

I have added this from today.  I have called the tree s5p.  Currently you
alone are the contact for problems to do with this tree - should I add
anyone else (or a mailing list)?

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
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100624/b2a5607a/attachment-0001.sig>
