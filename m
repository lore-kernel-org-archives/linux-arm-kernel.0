From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 1 May 2012 10:27:15 +1000
Subject: Request for inclusion of ep93xx tree in linux-next
In-Reply-To: <4F9F16A9.9090108@gmail.com>
References: <4F9F16A9.9090108@gmail.com>
Message-ID: <20120501102715.12aaaf0a846059f486682221@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

On Tue, 01 May 2012 08:48:09 +1000 Ryan Mallon <rmallon@gmail.com> wrote:
>
> Can you please add the following branches:
> 
>   ep93xx-cleanup
>   ep93xx-fixes
> 
> from the ep93xx git tree:
> 
>   git://github.com/RyanMallon/linux-ep93xx.git
> 
> To linux-next. Both branches are stable and based on v3.4-rc2. Testing
> for the tree is covered by the arm ep93xx_defconfig.

I have added these from today as ep93xx-current (fixes for Linus' current
tree - branch ep93xx-fixes) and ep93xx (stuff for the next merge window -
branch ep93xx-cleanup).  I have listed just you as the contact in case I
have problems (conflicts, build failures, unable to fetch etc).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120501/09378d73/attachment.sig>
