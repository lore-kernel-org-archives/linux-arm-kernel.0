From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Jan 2016 12:04:12 +0000
Subject: [GIT PULL] UEFI support for 32-bit ARM
In-Reply-To: <CAKv+Gu_Kwx7iOMFcUPEd5ORxn5=-qKuE7mGniCvoLbAqRbhK6w@mail.gmail.com>
References: <CAKv+Gu_QvQnsYk=coEJQrRk94xATT9Fi5=9jCZhLoNUvTU7kJg@mail.gmail.com>
 <20151222123642.GG8644@n2100.arm.linux.org.uk>
 <CAKv+Gu8sJdNd4FK2sycCFuQ2c4NC6Gy-a3CJ13NiV69sMqVkzQ@mail.gmail.com>
 <20151222125403.GI8644@n2100.arm.linux.org.uk>
 <CAKv+Gu_Kwx7iOMFcUPEd5ORxn5=-qKuE7mGniCvoLbAqRbhK6w@mail.gmail.com>
Message-ID: <20160102120410.GV8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 29, 2015 at 08:40:33AM +0100, Ard Biesheuvel wrote:
> On 22 December 2015 at 13:54, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Dec 22, 2015 at 01:51:23PM +0100, Ard Biesheuvel wrote:
> >>  29 files changed, 986 insertions(+), 368 deletions(-)
> >
> > Thanks, that now matches.
> >
> 
> I suppose the fact that none of this has turned up in -next implies
> that it will not make v4.5?

I pulled it into my devel-testing branch on 22nd, which is the
pre-cursor to it appearing in devel-stable (devel-stable is for
stuff which has passed my testing.)  I never got around to
merging it into devel-stable prior to the Christmas break.

I suspect even if I did publish it, we'd find that -next wouldn't
have picked it up - just before I took a break, I merged the PL011
changes which would conflict with those which GregKH incorrectly
picked up, and I know that linux-next hasn't reported any conflicts.
Ergo, linux-next has taken a break over the christmas period as well.

If Linus decides to do -rc8 tomorrow, I'll merge it into devel-stable
and it'll appear in -next.

Even if I merge it into my for-next branch _now_, it won't appear in
-next prior to Monday, and so if Sunday sees the release of v4.4, it
won't have been in -next prior to the merge window, and will be dodgy
to send to Linus (Linus sometimes compares what he merges against
linux-next.)

So... I'll decide on Monday what to do.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
