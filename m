From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 17 Sep 2014 09:05:09 +0200
Subject: Cortex-M and zImage
In-Reply-To: <CAGhQ9VyhXywQ2kBKK9K5McQf153qXzgsPzt3GoCCL=QjWR2ogw@mail.gmail.com>
References: <CAGhQ9VzzSq4P5BKM3UBBCPT61g3T1RHFhttfA-KkWGCcrjaW6A@mail.gmail.com>
 <20140917061110.GM3755@pengutronix.de>
 <CAGhQ9VyhXywQ2kBKK9K5McQf153qXzgsPzt3GoCCL=QjWR2ogw@mail.gmail.com>
Message-ID: <20140917070509.GN3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joachim,

On Wed, Sep 17, 2014 at 08:55:05AM +0200, Joachim Eastwood wrote:
> On 17 September 2014 08:11, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > I was able to compile a zImage with the patch below. For the
> > "Conflicting architecture profiles" error the most relevant hunk is the
> > first. And of course this needs some #ifdefs.
> 
> Thanks, I'll give it a try later today.
> 
> But is this the way to go?
> Adding lots of 'ifdefs CONFIG_CPU_V7M' to compressed/head.S ?
Probably not lots. I would expect (and hope) that you won't need more
than a handful. I don't see an alternative.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
