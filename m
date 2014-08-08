From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Aug 2014 15:45:10 +0100
Subject: Request to include Mailbox tree in linux-next
In-Reply-To: <CAJe_Zhcy+CjXa218gWNFR=O1U7g3iXGQ8s+VwgoGKamk3ysoKw@mail.gmail.com>
References: <CAJe_ZhdZTSs+Ns4u7bMXwbLHYTnE-5XEE8uev4zXbXrCP52bSg@mail.gmail.com>
 <20140808142912.7bf68229@canb.auug.org.au>
 <20140808103021.GA30282@n2100.arm.linux.org.uk>
 <CAJe_Zhcy+CjXa218gWNFR=O1U7g3iXGQ8s+VwgoGKamk3ysoKw@mail.gmail.com>
Message-ID: <20140808144510.GF30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 08:03:01PM +0530, Jassi Brar wrote:
> On 8 August 2014 16:00, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Fri, Aug 08, 2014 at 02:29:12PM +1000, Stephen Rothwell wrote:
> >> Hi Jassi,
> >>
> >> On Wed, 6 Aug 2014 12:25:49 +0530 Jassi Brar <jaswinder.singh@linaro.org> wrote:
> >> >
> >> >  The framework for Mailbox has undergone 10 revisions over the last
> >> > one year, which has garnered support in the form of 'Reviewed-by' and
> >> > 'looks good enough to be merged in this window' from people in the CC
> >> > list.
> >> >
> >> >   Could you please add it to linux-next?
> >> > Tree:       git://git.linaro.org/landing-teams/working/fujitsu/integration.git
> >> > Branch:   mailbox-for-3.17
> >> > Contact:  Jassi Brar <jaswinder.singh@linaro.org>
> >>
> >> This is really late for v3.17.  The purpose of linux-next is to
> >> discover interactions between trees before they are pulled into Linus'
> >> tree and to do some cross architecture build checking.  Adding a tree
> >> during the merge window is not very helpful to that.
> >
> > +1.
> >
> > The same goes for any tree which is part of linux-next.
> >
> > Having a tree in linux-next carries with it the responsibility that the
> > tree owner abides by the kernel development cycle, which includes
> > respecting the moratorium on merging new development into branch(es)
> > which are part of linux-next during an actively open merge window.
> >
> I wasn't aware that any new subsystem must live at least one cycle in
> linux-next, I submitted it for inclusion just because someone
> suggested that as the next best thing to merging this cycle.

Not "one cycle" but the general rule is that changes must be queued in
linux-next at the latest one week before the merge window opens.

What is a definite no-no is introducing new development which haven't
been seen in linux-next during an open merge window.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
