From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Feb 2012 16:10:45 +0000
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <4F4BDA24.1070807@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <201202141716.26930.arnd@arndb.de> <4F4BDA24.1070807@gmail.com>
Message-ID: <201202281610.45909.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 February 2012, Rob Herring wrote:
> >>
> >> This looks correct AFAICT.
> >>
> >> We could just call the 3rd category legacy and move on.
> > 
> > I'm not ready to give up that fast. The platforms seem to be implemented
> > reasonably well compared to category 2, but they can't be converted in
> > a completely mechanical way. The patch below should put iop13xx it into
> > category 1, but it really needs testing and review by a person who
> > understands that platform. I can also take a look at the others if we
> > agree that this is the right approach.
> > 
> 
> It looks fine to me and I'm happy to pull it in, but who can test?
> There's almost no commits specific to iop13xx going back to 2009. The
> PCI related code goes back to 2007. I've added a couple of Intel folks
> that did the original support.

Lennert and Dan are still listed as maintainers, so I would hope that
at least one of them would be able to Ack the patch and do the amount
of testing they see as appropriate. If they have both moved on and
cannot test it any more, the chances are that the platform is already
bitrotted and broken.

	Arnd
