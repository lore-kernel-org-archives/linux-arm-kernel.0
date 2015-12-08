From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 11:05:08 +0100
Subject: [PATCH v2 0/7] ARM: orion5x/mv78xx0 multiplatform
In-Reply-To: <871taycgww.fsf@free-electrons.com>
References: <1449091629-2155735-1-git-send-email-arnd@arndb.de>
 <871taycgww.fsf@free-electrons.com>
Message-ID: <8701651.rk8MftG23Y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 December 2015 18:22:39 Gregory CLEMENT wrote:
>  On mer., d?c. 02 2015, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > I've updated the series slightly to leave out the last two patches for
> > mach-dove. I think the MULTI_IRQ_HANDLER and SPARSE_IRQ use is useful
> > to have for all three platforms for consistency, and the watchdog change
> > is required to get orion5x to work right.
> >
> > Please have another look.
> >
> > I've also uploaded this series to
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git multiplatform-orion-4.3
> >
> > again, that version is based on v4.3, while the patches in these mails
> > are based on v4.4-rc3.
> >
> > I've left Andrew's Ack in place, hope that's ok.
> >
> 
> I applied the series on mvebu/soc and I will try to see if I can test it
> on an mv78xx0 board.
> 
> I applied the series on v4.4-rc1, so I had to merge "manually" the
> second patch. If everything goes well, should I use the v4.4-rc3 as
> reference for the pull request?

-rc1, -rc2 and -rc3 are all fine, but I'd like to avoid pulling
in later -rc releases.

	Arnd
