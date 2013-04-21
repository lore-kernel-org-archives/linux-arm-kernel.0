From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 22 Apr 2013 01:12:53 +1000
Subject: KVM/ARM in next
In-Reply-To: <CAEDV+gK-84M+6zx_z1z48sNi5UiaELdsbz983tE7GOS25SnymA@mail.gmail.com>
References: <CAEDV+gK-84M+6zx_z1z48sNi5UiaELdsbz983tE7GOS25SnymA@mail.gmail.com>
Message-ID: <20130422011253.9588b1a1e99a69a5991d7268@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On Sat, 20 Apr 2013 09:59:20 -0700 Christoffer Dall <cdall@cs.columbia.edu> wrote:
>
> I'm maintaining the KVM/ARM implementation, which was merged during
> the 3.9 merge window.
> 
> I'd like for you to pull changes from my kvm-arm-next branch at
> git://github.com/columbia/linux-kvm-arm.git into linux-next.
> 
> The merge procedure for this tree is typically through the kvm tree,
> but occasionally through Russell King's ARM tree, if there are
> substantial changes to generic ARM code in there.
> 
> In case of problems please notify me and Marc Zyngier <marc.zyngier@arm.com>

I have added your tree from today with you and Marc as contacts.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130422/0614f363/attachment.sig>
