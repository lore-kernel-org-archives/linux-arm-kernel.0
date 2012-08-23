From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Aug 2012 13:32:40 +0000
Subject: [PATCH 2/6] ARM: omap: allow building omap44xx without SMP
In-Reply-To: <CAMQu2gzPMkbDvTfTOZVp+Qh=2=AHOuyt4NXtxAps=RmMF+mf6Q@mail.gmail.com>
References: <1345648390-4234-1-git-send-email-arnd@arndb.de>
 <201208231212.04869.arnd@arndb.de>
 <CAMQu2gzPMkbDvTfTOZVp+Qh=2=AHOuyt4NXtxAps=RmMF+mf6Q@mail.gmail.com>
Message-ID: <201208231332.40530.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 August 2012, Shilimkar, Santosh wrote:
> 
> On Thu, Aug 23, 2012 at 5:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thursday 23 August 2012, Shilimkar, Santosh wrote:
> > > I see your point but alternate patch is pushing down the fix to the low
> > > level driver and that means you end up patching more drivers when they
> > > use COUPLE idle infrastructure. That was the only reason I was thinking
> > > of suppressing the error at the source.
> > >
> > > Since it is just for the random builds and actually doesn't impact the
> > > real
> > > functionality as such, I am fine with your proposed patch too.
> >
> > Ok. It would be nice of course to test if this actually works on
> > uniprocessor
> > configurations.
> >
> Have tested the patch and it does boot with UP build on OMAP.
> 
> Acked-tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Ok, thanks a lot!

	Arnd
