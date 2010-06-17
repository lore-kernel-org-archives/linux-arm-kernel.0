From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 18 Jun 2010 09:08:57 +1000
Subject: [GIT PULL linux-next] tegra
In-Reply-To: <AANLkTikXH_UtE95ZGHp5AAm5IRD6dN8cnrNK9A3-MRwY@mail.gmail.com>
References: <AANLkTikXH_UtE95ZGHp5AAm5IRD6dN8cnrNK9A3-MRwY@mail.gmail.com>
Message-ID: <20100618090857.057e0a7a.sfr@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Thu, 17 Jun 2010 15:38:19 -0700 Erik Gilling <konkers@android.com> wrote:
>
> Can you please pull the following into linux-next?
> 
> git://android.git.kernel.org/kernel/tegra.git for-next
> 
> This tree adds support for the Nvidia Tegra ARM SOCs.  It's received
> review on linux-arm-kernel.

Added from today.  Should the contact be just you or should I add others
as well.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100618/5840dba5/attachment.sig>
