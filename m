From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 13 Dec 2012 13:20:49 +0000
Subject: linker problem with xip kernel and recent toolchains
In-Reply-To: <50C83EB1.5050509@pengutronix.de>
References: <50BE0CDB.5000704@pengutronix.de>
 <1355230894.19818.1.camel@hornet> <50C7386E.70305@pengutronix.de>
 <1355249468.19818.23.camel@hornet> <50C83EB1.5050509@pengutronix.de>
Message-ID: <1355404849.19818.49.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-12-12 at 08:22 +0000, Marc Kleine-Budde wrote:
> On 12/11/2012 07:11 PM, Pawel Moll wrote:
> > On Tue, 2012-12-11 at 13:43 +0000, Marc Kleine-Budde wrote:
> >> What about putting the notes section into the read only segment, i.e.
> >> the ROM?
> > 
> > Could you, please, try the change below? It seems to do the job for me.
> 
> Works for me. The kernel image links to 640 KiB again.

Cool, I'll get it into Russell's patch system then (with your Reported-
and Tested-by).

Thanks!

Pawe?
