From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Nov 2012 18:54:14 +0000
Subject: [GIT PULL] ARM: ixp4xx: fixes for v3.7
In-Reply-To: <CAOesGMhRKfhjvhb0u+qADwpSJZbXEhXzbZAFgOdnbkmMgYy0mw@mail.gmail.com>
References: <0Lufa8-1TAtF11yb2-00zw9g@mx.kundenserver.de>
 <201211261314.32662.arnd@arndb.de>
 <CAOesGMhRKfhjvhb0u+qADwpSJZbXEhXzbZAFgOdnbkmMgYy0mw@mail.gmail.com>
Message-ID: <201211261854.14248.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 26 November 2012, Olof Johansson wrote:

> > Olof, I'm undecided whether they are still appropriate for 3.7 since
> > we're past the final -rc now. If we want them in, we should probably
> > send them to Linus now and let him decide.  For all I can tell, ixp4xx
> > is already completely broken without these patches, so there should be
> > no harm in including them, but then again " 13 files changed, 59
> > insertions(+), 68 deletions(-)" is slightly more than I'd like to send
> > at this point.
> >
> > If you prefer, we can put them into next/fixes-non-critical, but then we
> > might want to mark more of them as candidates for stable.
> 
> Since the code has been broken for quite a while, I don't see a big
> urgency to get it in in the last week of a new release, but I can
> easily be persuaded differently. Had I done the pull, I would probably
> have merged them into fixes-non-critical myself.

I've just done a few pulls that I've found in my email backlog, but it
seems you already had everything under control, I was expecting more
work to be left over. I probably woudn't have started if I had known
it was this little. At least I have a good feeling about not having
missed anything important now.
 
> But, as I said, I don't have strong opinions on the matter. :)

I can send the pull request(s) for the fixes this time, so at least
Linus doesn't blame you for what I pulled in ;-)

	Arnd
