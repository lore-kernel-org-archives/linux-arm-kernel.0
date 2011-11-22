From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 23 Nov 2011 01:36:46 +1100
Subject: Inclusion of ARM perf tree in linux-next
In-Reply-To: <20111122100435.GC20518@mudshark.cambridge.arm.com>
References: <20111122100435.GC20518@mudshark.cambridge.arm.com>
Message-ID: <20111123013646.8acd19e7f4c615a7bf8306a4@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, 22 Nov 2011 10:04:35 +0000 Will Deacon <will.deacon@arm.com> wrote:
>
> I maintain the ARM perf backend and would be very grateful if you could
> please include this branch in linux-next:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
> 
> This request has arisen specifically from some work with the OMAP guys
> where it would be useful to spot any conflicts for 3.3, however I think it's
> generally a good idea for me to give some of the perf changes an airing
> before they get merged anyway.

I have added that tree now with you as the contact.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111123/719847b0/attachment.sig>
