From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Dec 2011 09:49:34 +1100
Subject: linux-next: please update URL for arm-soc tree
In-Reply-To: <CAOesGMgUJAH01p20Kx=DOTN1T-fxJDVHbtDFRno4cUPcnbHFMw@mail.gmail.com>
References: <CAOesGMgUJAH01p20Kx=DOTN1T-fxJDVHbtDFRno4cUPcnbHFMw@mail.gmail.com>
Message-ID: <20111213094934.6dae2e13597a25fbaaa0e7fd@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Mon, 12 Dec 2011 08:45:59 -0800 Olof Johansson <olof@lixom.net> wrote:
>
> The arm-soc tree is back on kernel.org, so can you please update the
> tree you pull to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git  for-next
> 
> Contacts for merge conflicts are Arnd, me and the linux-arm-kernel list.

OK, I have switched to that now.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111213/9ccc76f1/attachment.sig>
