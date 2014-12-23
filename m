From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 23 Dec 2014 17:32:34 +1100
Subject: linux-next: missing merge fix patch for the merge of the
 xen-tip tree with the arm-soc tree
In-Reply-To: <CA+55aFwQKe0PvSuYqOeQMM8kouB3mkyQQ=gFMX=bkPx3GxanvA@mail.gmail.com>
References: <20141208184908.27bfd605@canb.auug.org.au>
 <20141208103328.GE27367@arm.com>
 <20141223132605.02d81e01@canb.auug.org.au>
 <CA+55aFwQKe0PvSuYqOeQMM8kouB3mkyQQ=gFMX=bkPx3GxanvA@mail.gmail.com>
Message-ID: <20141223173234.7c4c45f5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, 22 Dec 2014 20:09:50 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> On Mon, Dec 22, 2014 at 6:26 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Linus,
> >
> > I have been carrying this merge fix patch for some time that is now
> > needed in your tree:
> 
> No, it's not. Look more closely.
> 
> My merge put the
> 
>         dev->archdata.dma_coherent = coherent;
> 
> line at the top of the function, like the way it was in the original commit.

Oops, sorry about that.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141223/5d0da7e0/attachment-0001.sig>
