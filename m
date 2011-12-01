From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Dec 2011 09:08:12 +0000
Subject: Fwd: Re: [03: PATCH 0/5] The remaining stuff
In-Reply-To: <20111128104554.GA2165@local>
References: <20111124204447.GW9581@n2100.arm.linux.org.uk>
 <20111128104554.GA2165@local>
Message-ID: <20111201090812.GZ9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 11:45:55AM +0100, Hans J. Koch wrote:
> On Thu, Nov 24, 2011 at 08:44:47PM +0000, Russell King - ARM Linux wrote:
> > The list of platforms which are still broken (today) by part 2 of this
> > series are:
> > 
> > arch/arm/mach-davinci/include/mach/system.h
> > arch/arm/mach-gemini/include/mach/system.h
> > arch/arm/mach-nomadik/include/mach/system.h
> > arch/arm/mach-s3c2410/include/mach/system-reset.h
> > arch/arm/mach-s3c64xx/include/mach/system.h
> > arch/arm/mach-shmobile/include/mach/system.h
> > arch/arm/mach-vt8500/include/mach/system.h
> > arch/arm/plat-samsung/include/plat/system-reset.h
> > arch/arm/plat-tcc/include/mach/system.h
> > 
> > which require assistance to get these into shape.
> > 
> > As I've already implied, I'm quite prepared to break these platforms at
> > the next merge window for the greater good if there's no sign of
> > maintainers willing to help sort them out - which will then ultimately
> > result in them being deleted from mainline.
> 
> For the past 12 months, nobody was interested in Telechips (plat-tcc).
> No community, no customers, no support from Telechips. Under these
> circumstances, I am not willing to maintain this forever.
> 
> However, Harry Sievers, European distributor of Telechips, told me
> that there are persons at Telechips who are interested in having
> their stuff in mainline. He will tell them it is threatened with
> being deleted from mainline, and ask for support.
> 
> I am willing to wait until christmas for any news from Harry, and
> will then send a patch. Either one that fixes the arch as requested in
> the mail above, or one that removes the whole platform from mainline.
> My feeling is that the latter is more likely.
> 
> Russell, if that is too late for you, please let us know.

I doubt that we'll see -final before Christmas, so that should be fine.
If it's still not fixed up for these changes when -final is getting close,
I will delete it myself.

Thanks.
