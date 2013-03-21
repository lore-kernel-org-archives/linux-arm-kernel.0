From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 22 Mar 2013 10:12:03 +1100
Subject: Request the linux-next inclusion for IMX/MXS tree
In-Reply-To: <20130321015602.GA23109@S2101-09.ap.freescale.net>
References: <20130321015602.GA23109@S2101-09.ap.freescale.net>
Message-ID: <20130322101203.5c986794c37e1d072a2fbcfc@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, 21 Mar 2013 09:56:04 +0800 Shawn Guo <shawn.guo@linaro.org> wrote:
>
> Can you please help include the following branch into linux-next?
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git for-next
> 
> I used to rely on arm-soc's for-next branch to expose the IMX/MXS
> patches I collect on linux-next.  But it turns out that the procedure
> takes a longer time than I expect to finish, and it causes that patches
> are not shown on linux-next in time and problems are not found at the
> earliest time.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130322/77d93120/attachment.sig>
