From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 21:03:58 +0200
Subject: [PATCH v10 0/2] (arm-soc for v3.10) arm: introduce psci_smp_ops
In-Reply-To: <20130502184801.GF14496@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.02.1304301707290.5398@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1305021938170.5398@kaball.uk.xensource.com>
 <20130502184801.GF14496@n2100.arm.linux.org.uk>
Message-ID: <201305022103.58445.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Russell King - ARM Linux wrote:
> The only issue that there is is where we are in the development cycle
> (almost mid merge window), and I've yet to push anything to Linus thanks
> to late discovery of various messups in other chunks of code submitted
> via my tree - I'm starting to drop stuff from my tree in the hope that
> I'll get back to something that's going to be suitable for mainline.
> 
> I really don't want to go pulling anything else at the moment in the
> hope of getting what I currently have out the door.
> 
> And in any case, we shouldn't be adding any new code to our trees at
> this point in time.

Agreed. I would have like to see the patches in 3.10, but the timing
didn't work out.

Stefano, I'm sure we can queue it up early for 3.11 if you send them
again after the merge window. Sorry you had to go through 10 versions
and not getting it merged in time in the end.

	Arnd
