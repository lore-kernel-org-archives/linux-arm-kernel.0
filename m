From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 20 Dec 2013 09:39:16 +1100
Subject: Could you include clockevents/clocksource tree in linux-next ?
In-Reply-To: <52B363F1.2080209@linaro.org>
References: <52B363F1.2080209@linaro.org>
Message-ID: <20131220093916.06b43263127f5d6428a9056f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thu, 19 Dec 2013 22:24:01 +0100 Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> is it possible to add the clockevents/clocksource tree in linux-next.
> 
> git://git.linaro.org/people/daniel.lezcano/linux.git clockevents/next
> 
> It will be based on top of tip/timers/core.

Added from today.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/981d3b39/attachment.sig>
