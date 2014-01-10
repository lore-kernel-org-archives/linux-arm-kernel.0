From: horms@verge.net.au (Simon Horman)
Date: Fri, 10 Jan 2014 09:47:24 +0900
Subject: linux-next: manual merge of the sh tree with the tree
In-Reply-To: <CAOesGMgJe9KR2muA4F9EaXYpDFDLxVZsKOj-8qZFbDZTiRBuww@mail.gmail.com>
References: <20140106121317.bada4233ec3fec40f79735cc@canb.auug.org.au>
 <CAOesGMgJe9KR2muA4F9EaXYpDFDLxVZsKOj-8qZFbDZTiRBuww@mail.gmail.com>
Message-ID: <20140110004724.GA22965@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 11:11:03PM -0800, Olof Johansson wrote:
> On Sun, Jan 5, 2014 at 5:13 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Paul,
> >
> > Today's linux-next merge of the sh tree got conflicts in
> > drivers/tty/serial/sh-sci.c and include/linux/serial_sci.h between
> > commits 8fb9631c517b ("serial: sh-sci: Sort headers alphabetically"),
> > 20bdcab8268c ("serial: sh-sci: Add OF support") and probably others from
> > the arm-soc tree and commits ada80ee7fa60 ("serial: sh-sci: Add OF
> > support") and b19ef75c56e9 ("serial: sh-sci: OF definitions need
> > linux/of.h") from the sh tree.
> >
> > The arm-soc tree version is dated much more recently than
> > the sh tree version and conflicts badly, so for today I have just dropped
> > the sh tree (everything in there was committed before April 2013).  Please
> > figure this out.
> 
> The request to merge the sh code came through Simon with claimed
> agreement from SH maintainers to do so -- I didn't verify this since
> they have in the past been well-coordinated. Simon?

I spoke with Paul recently and my understanding is that
he hasn't been actively working in this area for over a year now.

I guess there are some stale patches in his tree.
