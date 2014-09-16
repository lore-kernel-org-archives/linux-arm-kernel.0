From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 16 Sep 2014 18:47:09 +1000
Subject: Request to include Mailbox tree in linux-next
In-Reply-To: <CAJe_ZhcRs45Rmzpjb-O+A=+HCUt9SspdgPofMkqd5+xL=TYwDA@mail.gmail.com>
References: <CAJe_ZhdZTSs+Ns4u7bMXwbLHYTnE-5XEE8uev4zXbXrCP52bSg@mail.gmail.com>
 <20140808142912.7bf68229@canb.auug.org.au>
 <CAJe_ZhceR1j_b-_efJoq9Dv6X6C=UuMgyp8AofjcCvc+bQVkfw@mail.gmail.com>
 <20140808144137.GE30282@n2100.arm.linux.org.uk>
 <CAJe_Zhc+_zCB+7196rsHb=KxG4JyuvyODXCpEX-y4XhwRjoBrw@mail.gmail.com>
 <20140809015857.17af92e7@canb.auug.org.au>
 <CAJe_ZhcRs45Rmzpjb-O+A=+HCUt9SspdgPofMkqd5+xL=TYwDA@mail.gmail.com>
Message-ID: <20140916184709.7fb9a885@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On Mon, 15 Sep 2014 20:40:50 -0700 Jassi Brar <jaswinder.singh@linaro.org> wrote:
>
> On 8 August 2014 08:58, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Fri, 8 Aug 2014 20:40:47 +0530 Jassi Brar <jaswinder.singh@linaro.org> wrote:
> >>
> >> On 8 August 2014 20:11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> >> >> Upon Mark's suggestion (and the right thing to do) I wanted the patchset
> >> >> to live the cycle in linux-next.
> >> >
> >> > Yes, that's the right thing to do, but you sent the request at an
> >> > inappropriate time.  The correct time to send your request would be
> >> > after 3.17-rc1 has been released, IOW after the current merge window
> >> > is over.
> >> >
> >> > In general, kernel developers don't "remember" requests from one week
> >> > to the next; instead, we much prefer people send their requests at the
> >> > appropriate times in the development cycle.
> >> >
> >> OK, thanks for explaining.
> >
> > As Russell has said, if you remind me after -rc1 is out, I will add
> > your tree then.  I will try to remember, but don't depend on it.
> >
> Hi Stephen, Could you please add now ?
> 
> Tree:       git://git.linaro.org/landing-teams/working/fujitsu/integration.git
> Branch:   mailbox-for-next
> Contact:  Jassi Brar <jaswinder.singh@linaro.org>

Added from tomorrow.

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
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140916/fb47431e/attachment-0001.sig>
