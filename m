From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 29 Oct 2012 10:07:04 +1100
Subject: Please add bcm2835 tree to linux-next
In-Reply-To: <5089FD2F.9090507@wwwdotorg.org>
References: <5089FD2F.9090507@wwwdotorg.org>
Message-ID: <20121029100704.37f017de8b0ed0173c5d68cc@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, 25 Oct 2012 21:02:07 -0600 Stephen Warren <swarren@wwwdotorg.org> wrote:
>
> Could you please add the bcm2835 ARM SoC tree to linux-next. It's
> available at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git for-next
> 
> Its probably best to insert it into the list somewhere after the
> existing arm-soc tree. I also maintain the Tegra tree, so if you insert
> it right next to that, any issues related to me will be triggered at the
> same time:-)
> 
> Right now, it's based on v3.7-rc2, plus 5 patches.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121029/36a8a1b8/attachment.sig>
