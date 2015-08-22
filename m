From: mingo@kernel.org (Ingo Molnar)
Date: Sat, 22 Aug 2015 12:09:22 +0200
Subject: [PATCH 0/2] x86/KASAN updates for 4.3
In-Reply-To: <20150813172310.GK10280@arm.com>
References: <1439444244-26057-1-git-send-email-ryabinin.a.a@gmail.com>
 <20150813065040.GA17983@gmail.com>
 <20150813081641.GA14402@gmail.com> <20150813090119.GA10280@arm.com>
 <CAPAsAGxk2+v5VG77cOHAThsXyWx-_UJ1XVeJProaa0gQWH5jvA@mail.gmail.com>
 <20150813112428.GG10280@arm.com> <20150813172310.GK10280@arm.com>
Message-ID: <20150822100922.GA25039@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Will Deacon <will.deacon@arm.com> wrote:

> On Thu, Aug 13, 2015 at 12:24:28PM +0100, Will Deacon wrote:
> > On Thu, Aug 13, 2015 at 12:02:26PM +0100, Andrey Ryabinin wrote:
> > > 2015-08-13 12:01 GMT+03:00 Will Deacon <will.deacon@arm.com>:
> > > > Yes please, works for me! If we're targetting 4.3, then please can you base
> > > > on 4.2-rc4, as that's what our current arm64 queue is using?
> > > >
> > > 
> > > Does this mean that we are targeting arm64 part for 4.3 too?
> > 
> > It depends on how well it merges with our current queue and whether it
> > holds up to regression testing. The patches have been reviewed, so I'm
> > comfortable with the content, but we're not at a stage where we can debug
> > and fix any failures that might crop up from the merge.
> 
> Scratch that :(
> 
> I tried this out under EFI and it dies horribly in the stub code because
> we're missing at least one KASAN_SANITIZE_ Makefile entry.
> 
> So I think this needs longer to stew before hitting mainline. By all means
> get the x86 dependencies in for 4.3, but the arm64 port can probably use
> another cycle to iron out the bugs.

Is there any known problem with the two patches in this series, or can I apply 
them?

Thanks,

	Ingo
