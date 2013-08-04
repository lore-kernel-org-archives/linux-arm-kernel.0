From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 4 Aug 2013 21:36:47 +0200
Subject: Build breakage due to latest ARM fixes
In-Reply-To: <CAOesGMiDBT9NAhCiVe0mMTk4KXJZVynNaBHqk5+T9a6QYaFZvw@mail.gmail.com>
References: <CAOesGMgWeP-CdmOE-S7XZmJ-+1buP9a1cqavUns2gpgKrrhaxQ@mail.gmail.com>
 <20130803000731.GS23006@n2100.arm.linux.org.uk>
 <20130804125346.GH23006@n2100.arm.linux.org.uk>
 <CAOesGMhNr5-6T9s8Y9jr2pWy=baceuZwGFNj2HtnqU9DbwPLvw@mail.gmail.com>
 <20130804183708.GI23006@n2100.arm.linux.org.uk>
 <CAOesGMiDBT9NAhCiVe0mMTk4KXJZVynNaBHqk5+T9a6QYaFZvw@mail.gmail.com>
Message-ID: <20130804193647.GD6104@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Aug 04, 2013 at 11:47:04AM -0700, Olof Johansson wrote:
> On Sun, Aug 4, 2013 at 11:37 AM, Russell King - ARM Linux
> > The only real testing I'm aware of is when I recreated the OKI67001
> > support a while back and got my board to boot.
> 
> Uwe has been busy pushing various patches for M3/M4 support, I don't
> know how far it is from having some real hardware usable though. Uwe?
On my efm32 devboard I have 3.11-rc running. The missing bits are
available in my efm32 branch at

	git://git.pengutronix.de/git/ukl/linux.git efm32
	http://git.pengutronix.de/?p=ukl/linux.git;a=shortlog;h=refs/heads/efm32

. It's not yet in a form ready for mainline but there isn't much
missing. There is one problem I didn't debug yet (/proc/devicetree
doesn't appear although I have the respective Kconfig symbol on); other
than that I didn't notice any no-mmu problems. Also Jonathan Austin does
some no-MMU work.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
