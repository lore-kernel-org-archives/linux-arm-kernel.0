From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Feb 2014 20:57:03 +0000
Subject: [PATCH 4/5] mfd: remove obsolete ti-ssp driver
In-Reply-To: <20140226125157.GM9195@lee--X1>
References: <1393418614-3968549-1-git-send-email-arnd@arndb.de>
 <1393418614-3968549-5-git-send-email-arnd@arndb.de>
 <20140226125157.GM9195@lee--X1>
Message-ID: <20140226205703.GA21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 12:51:57PM +0000, Lee Jones wrote:
> > The tnetv107x platform is getting removed, so this driver
> > is not needed any more.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/Kconfig  |  11 --
> >  drivers/mfd/Makefile |   1 -
> >  drivers/mfd/ti-ssp.c | 465 ---------------------------------------------------
> >  3 files changed, 477 deletions(-)
> >  delete mode 100644 drivers/mfd/ti-ssp.c
> 
> Applied, thanks.

This makes me wonder whether you apply any patch you receive via email,
or whether you read the covering email first.

Arnd's 0/5 email said:

	However, I'm looking for an Ack from
	Cyril Chemparathy and Sekhar Nori first, to be sure we
	won't need this code in the future.

This is exactly the reason why I'd now recommend that if people want to
send out patches which they don't intend maintainers to take, that they
use "[PATCH RFC" in the subject _and_ they make sure that the patch can't
be trivially applied.  That means maintainers have to (a) not notice the
RFC in the subject, and _then_ they have to intentionally fix the patch
before applying.  Both taken together will be sufficient deterrent for
this kind of mistake happening.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
