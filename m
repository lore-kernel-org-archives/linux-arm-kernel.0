From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 13 Feb 2012 11:21:45 +1100
Subject: [PULL REQUEST] DMA-mapping framework redesign preparation patches
In-Reply-To: <1328898737-15854-1-git-send-email-m.szyprowski@samsung.com>
References: <1328898737-15854-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120213112145.4b8990c739d297cd30714d52@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Fri, 10 Feb 2012 19:32:17 +0100 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Our patches with DMA-mapping framework redesign proposal have been
> hanging for over a month with just a few comments. We would like to go
> further in the development, but first I would like to ask You to give
> them a try in the linux-next kernel.
> 
> For everyone interested in this patch series, here is the relevant
> thread: https://lkml.org/lkml/2011/12/23/97
> 
> If there are any problems with our git tree, please contact Marek 
> Szyprowski <m.szyprowski@samsung.com> or alternatively Kyungmin Park
> <kyungmin.park@samsung.com>.
> 
> The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:
> 
>   Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)
> 
> are available in the git repository at:
>   git://git.infradead.org/users/kmpark/linux-samsung dma-mapping-next

I have added this from today.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120213/14b57ce3/attachment.sig>
