From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 3 Feb 2014 10:06:21 +0100
Subject: [PATCH v4] ARM/serial: at91: switch atmel serial to use gpiolib
In-Reply-To: <CACRpkdbHNo1bLxKaCCuOBiRq+JEpEPXdmQpr4BKAiORcb2snfw@mail.gmail.com>
References: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZNe0L+yZnqrY51Oeg+k5NHXebJAiqxi+p5Scy-BQ2+1w@mail.gmail.com>
 <52EBBB84.9050705@gmail.com>
 <20140131231618.GC11138@quad.lixom.net>
 <CACRpkdbHNo1bLxKaCCuOBiRq+JEpEPXdmQpr4BKAiORcb2snfw@mail.gmail.com>
Message-ID: <20140203090621.GX26766@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 09:34:31AM +0100, Linus Walleij wrote:
> On Sat, Feb 1, 2014 at 12:16 AM, Olof Johansson <olof@lixom.net> wrote:
> > On Fri, Jan 31, 2014 at 04:04:36PM +0100, Richard Genoud wrote:
> 
> >> I can't find this patch in linux-next, did I missed something ?
> >
> > Yeah, looks like we dropped the ball on it. We'll queue it up for 3.15 as soon
> > as -rc1 is out.
> 
> OK it's out now ;-)
I included it in my drop-<mach/timex.h> series that I wish to go into
3.15, too. The patch is the first in my series, commit 354e57f3a0a2. If
you want to take this patch but not my series, please still take this
one to prevent it going in twice.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
