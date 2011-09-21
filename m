From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Sep 2011 16:12:33 +0200
Subject: [PATCH 00/10] hwspinlock-next
In-Reply-To: <20110920231340.GT18894@atomide.com>
References: <1315846025-11453-1-git-send-email-ohad@wizery.com>
	<CAK=Wgbam6u1bq8fG+oMUhxfWH1g3dU7q+VhPWFEZOLgFMV_3vQ@mail.gmail.com>
	<20110920231340.GT18894@atomide.com>
Message-ID: <201109211612.33504.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 September 2011, Tony Lindgren wrote:
> * Ohad Ben-Cohen <ohad@wizery.com> [110920 01:34]:
> > On Mon, Sep 12, 2011 at 7:46 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > 
> > I'm wondering how hwspinlock updates like this should go upstream.
> > 
> > The first hwspinlock batch was picked by Tony, because it involved a
> > bulk of OMAP changes.
> > 
> > Hwspinlock isn't OMAP-specific anymore though (we gained support for
> > STE's u8500) and the vast majority of changes are in drivers/. We're
> > still very much ARM-related, though this may change too at some point
> > (c6x has a similar "hardware semaphore" peripheral like the u8500
> > does).
> > 
> > Tony, if you're still willing to pick up these updates I'd be happy to
> > send you pull requests of course.
> 
> I'd prefer for Greg to take these as these are drivers.
> 
> If he's not taking it at this point based on it being ARM only,
> I can take it then.

Sorry for replying late, I had accidentally ignored the entire thread.

My feeling is that it would be best for Ohad to send these directly
to Linus, since it's basically a standalone subsystem and he's listed
as the maintainer (well, after this series at least).

I'm also fine with any of the other paths like

ohad->GregKH->torvalds
ohad->arnd->torvalds
ohad->tmlind->torvalds
ohad->tmlind->arnd->torvalds

	Arnd
