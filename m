From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Jun 2013 10:07:56 +1000
Subject: Request inclusion of ARM MPIDR linearization patches into
 linux-next
In-Reply-To: <20130611174629.GA14453@e102568-lin.cambridge.arm.com>
References: <20130611174629.GA14453@e102568-lin.cambridge.arm.com>
Message-ID: <20130617100756.37c25388ab9f232b23321ce8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Tue, 11 Jun 2013 18:46:29 +0100 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>
> can I ask you please to include the following branch into linux-next:
> 
> git://linux-arm.org/linux-2.6-lp.git for-next
> 
> It contains significant changes in ARM PM core code and would like to give it
> wide coverage before requesting a pull. It has been already publicly posted,
> reviewed and tested.

Added from today with you as contact and called arm-mpidr.  I assume that
this will be merged via Russell's arm tree.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130617/765a413a/attachment.sig>
