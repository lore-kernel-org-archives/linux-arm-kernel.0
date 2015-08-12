From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Aug 2015 14:41:16 +0100
Subject: [PATCH v5 2/6] x86/kasan, mm: introduce generic
 kasan_populate_zero_shadow()
In-Reply-To: <CAPAsAGwnhnqJCh=sc97-=qrYHNQnDSjVR-xGertoMiNWHDbhrw@mail.gmail.com>
References: <1439259499-13913-1-git-send-email-ryabinin.a.a@gmail.com>
 <1439259499-13913-3-git-send-email-ryabinin.a.a@gmail.com>
 <20150811154117.GH23307@e104818-lin.cambridge.arm.com>
 <55CA21E8.2060704@gmail.com>
 <20150811164010.GJ23307@e104818-lin.cambridge.arm.com>
 <CAPAsAGwDNpRBLAvyCSpR9ZO9tAmHx-XYjVDZPECeQkU0WOw5jg@mail.gmail.com>
 <20150812093701.GH22485@arm.com>
 <CAPAsAGwnhnqJCh=sc97-=qrYHNQnDSjVR-xGertoMiNWHDbhrw@mail.gmail.com>
Message-ID: <20150812134116.GB23540@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 01:19:03PM +0100, Andrey Ryabinin wrote:
> 2015-08-12 12:37 GMT+03:00 Will Deacon <will.deacon@arm.com>:
> > On Wed, Aug 12, 2015 at 10:30:37AM +0100, Andrey Ryabinin wrote:
> >> 2015-08-11 19:40 GMT+03:00 Catalin Marinas <catalin.marinas@arm.com>:
> >> >
> >> > Not sure how you plan to merge it though since there are x86
> >> > dependencies. I could send the whole series via tip or the mm tree (and
> >> > I guess it's pretty late for 4.3).
> >>
> >> Via mm tree, I guess.
> >> If this is too late for 4.3, then I'll update changelog and send v6
> >> after 4.3-rc1 release.
> >
> > That's probably the best bet, as I suspect we'll get some non-trivial
> > conflicts with the arm64 tree at this stage.
> >
> Or, if x86 maintainers are agree to take first 2 patches in 4.3,
> the rest of the series could go into arm64 tree later.

Yup, that would be even better for us!

Will
