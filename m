From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 22 Dec 2014 20:09:50 -0800
Subject: linux-next: missing merge fix patch for the merge of the xen-tip
 tree with the arm-soc tree
In-Reply-To: <20141223132605.02d81e01@canb.auug.org.au>
References: <20141208184908.27bfd605@canb.auug.org.au>
 <20141208103328.GE27367@arm.com>
 <20141223132605.02d81e01@canb.auug.org.au>
Message-ID: <CA+55aFwQKe0PvSuYqOeQMM8kouB3mkyQQ=gFMX=bkPx3GxanvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 6:26 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Linus,
>
> I have been carrying this merge fix patch for some time that is now
> needed in your tree:

No, it's not. Look more closely.

My merge put the

        dev->archdata.dma_coherent = coherent;

line at the top of the function, like the way it was in the original commit.

                            Linus
