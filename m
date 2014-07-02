From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Jul 2014 23:55:32 -0700
Subject: FIX ME in function ocpi_enable in file arch/arm/mach-omap1/opci.c
In-Reply-To: <CAPDOMVgP83G4-znp=9kB-pBrfd2MUK+xvw1-_cRMXqi9P8hrww@mail.gmail.com>
References: <CAPDOMVgP83G4-znp=9kB-pBrfd2MUK+xvw1-_cRMXqi9P8hrww@mail.gmail.com>
Message-ID: <20140702065531.GS28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nick Krause <xerofoify@gmail.com> [140701 15:51]:
> Hey Tony and Russel ,
> There is a FIX ME message in this function of the file stated in my
> subject line.
> I was wondering what locking is needed  here due to not having experience with
> omap subsystem(s).

Looks like the locking for ocpi_enable would be needed if
it was called from multiple drivers. We are just enabling all
access, so no locking neeed for the current usage.

Regards,

Tony
