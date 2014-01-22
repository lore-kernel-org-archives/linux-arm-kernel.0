From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 22 Jan 2014 18:00:23 +1100
Subject: [PATCH RFC 00/73] tree-wide: clean up some no longer required
 #include <linux/init.h>
In-Reply-To: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20140122180023.dd90d34cba38d9f9ac516349@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Tue, 21 Jan 2014 16:22:03 -0500 Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
>
> Where: This work exists as a queue of patches that I apply to
> linux-next; since the changes are fixing some things that currently
> can only be found there.  The patch series can be found at:
> 
>    http://git.kernel.org/cgit/linux/kernel/git/paulg/init.git
>    git://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
> 
> I've avoided annoying Stephen with another queue of patches for
> linux-next while the development content was in flux, but now that
> the merge window has opened, and new additions are fewer, perhaps he
> wouldn't mind tacking it on the end...  Stephen?

OK, I have added this to the end of linux-next today - we will see how we
go.  It is called "init".

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140122/4f1e8752/attachment.sig>
