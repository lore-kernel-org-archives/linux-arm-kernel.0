From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 20 Dec 2011 04:09:03 +0100
Subject: [PATCH] MXS: Convert mutexes in clock.c to spinlocks
In-Reply-To: <20111220001946.GB5683@S2100-06.ap.freescale.net>
References: <1324217174-6574-1-git-send-email-marek.vasut@gmail.com>
 <201112200035.52802.marek.vasut@gmail.com>
 <20111220001946.GB5683@S2100-06.ap.freescale.net>
Message-ID: <201112200409.04529.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Dec 20, 2011 at 12:35:52AM +0100, Marek Vasut wrote:
> > > On Mon, Dec 19, 2011 at 09:54:25PM +0100, Marek Vasut wrote:
> > > > > So, in summary, you have everything you require to fix it outside
> > > > > the driver.  You just have to decide which of the two options you
> > > > > want to proceed with, and actually (and finally) do it instead of
> > > > > endlessly procrastinating and waiting for more and more bug
> > > > > reports (which is exactly what has happened so far.)
> > > 
> > > Marek, the 'you' here really means me rather than you.
> > 
> > Sure, I figured as much after Russells reply.
> > 
> > > Russell, sorry for leaving the issue here for long time, and I'm
> > > working on the patches you suggested right now.
> > 
> > I see ... shall I back off from this issue then? Can I somehow help you
> > on this?
> 
> I will try to work out the series soon, and you can help to see if it
> solves your problem.

All right, I'll be glad to review. Make sure to Cc me :)

Cheers!

M
