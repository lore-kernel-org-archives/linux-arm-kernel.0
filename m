From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 18 Feb 2014 10:46:44 +1100
Subject: [linux-next] Adding keystone kernel tree
In-Reply-To: <53028BD5.9010705@ti.com>
References: <53028BD5.9010705@ti.com>
Message-ID: <20140218104644.60a6f17f957b7034d015932d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Mon, 17 Feb 2014 17:23:17 -0500 Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>
> I would like to add keystone-linux next to linux-next to take advantage
> of testing and integration issues. The tree is already officially
> mentioned in the MAINTAINERS file
> 
> ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
> M:      Santosh Shilimkar <santosh.shilimkar@ti.com>
> L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> S:      Maintained
> F:      arch/arm/mach-keystone/
> F:      drivers/clk/keystone/
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
> 
> Can you please add 'next' branch from the git tree to linux-next ?

Added from today.  I assume that it will be merged via the arm-soc tree?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/78d926db/attachment.sig>
