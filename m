From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 10 Jan 2014 12:55:29 +1100
Subject: linux-next: manual merge of the sh tree with the tree
In-Reply-To: <20140110004724.GA22965@verge.net.au>
References: <20140106121317.bada4233ec3fec40f79735cc@canb.auug.org.au>
 <CAOesGMgJe9KR2muA4F9EaXYpDFDLxVZsKOj-8qZFbDZTiRBuww@mail.gmail.com>
 <20140110004724.GA22965@verge.net.au>
Message-ID: <20140110125529.9843f450bf79223164031b02@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Fri, 10 Jan 2014 09:47:24 +0900 Simon Horman <horms@verge.net.au> wrote:
>
> On Wed, Jan 08, 2014 at 11:11:03PM -0800, Olof Johansson wrote:
> >
> > The request to merge the sh code came through Simon with claimed
> > agreement from SH maintainers to do so -- I didn't verify this since
> > they have in the past been well-coordinated. Simon?
> 
> I spoke with Paul recently and my understanding is that
> he hasn't been actively working in this area for over a year now.
> 
> I guess there are some stale patches in his tree.

That is certainly what it looks like.  So, do I remove the sh{,.-current)
trees (git://github.com/pmundt/linux-sh.git#sh-{latest,fixes-for-linus})
from linux-next permanently?  Will it be cleaned up any time soon?

Is anyone maintaining/supporting sh now?  Is it a candidate for pruning?
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140110/16f407ca/attachment.sig>
