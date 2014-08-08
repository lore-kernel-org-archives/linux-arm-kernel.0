From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Aug 2014 11:30:21 +0100
Subject: Request to include Mailbox tree in linux-next
In-Reply-To: <20140808142912.7bf68229@canb.auug.org.au>
References: <CAJe_ZhdZTSs+Ns4u7bMXwbLHYTnE-5XEE8uev4zXbXrCP52bSg@mail.gmail.com>
 <20140808142912.7bf68229@canb.auug.org.au>
Message-ID: <20140808103021.GA30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 02:29:12PM +1000, Stephen Rothwell wrote:
> Hi Jassi,
> 
> On Wed, 6 Aug 2014 12:25:49 +0530 Jassi Brar <jaswinder.singh@linaro.org> wrote:
> >
> >  The framework for Mailbox has undergone 10 revisions over the last
> > one year, which has garnered support in the form of 'Reviewed-by' and
> > 'looks good enough to be merged in this window' from people in the CC
> > list.
> > 
> >   Could you please add it to linux-next?
> > Tree:       git://git.linaro.org/landing-teams/working/fujitsu/integration.git
> > Branch:   mailbox-for-3.17
> > Contact:  Jassi Brar <jaswinder.singh@linaro.org>
> 
> This is really late for v3.17.  The purpose of linux-next is to
> discover interactions between trees before they are pulled into Linus'
> tree and to do some cross architecture build checking.  Adding a tree
> during the merge window is not very helpful to that.

+1.

The same goes for any tree which is part of linux-next.

Having a tree in linux-next carries with it the responsibility that the
tree owner abides by the kernel development cycle, which includes
respecting the moratorium on merging new development into branch(es)
which are part of linux-next during an actively open merge window.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
