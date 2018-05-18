From: ndesaulniers@google.com (Nick Desaulniers)
Date: Fri, 18 May 2018 10:41:22 -0700
Subject: [PATCH] arm64: kvm: use -fno-jump-tables with clang
In-Reply-To: <CAKwvOdm1kYedukCq=g74AvqJHp6KC03oNoouQy2nkvfo4idoEw@mail.gmail.com>
References: <20180518170202.11458-1-samitolvanen@google.com>
 <05d14ac7-0feb-63a3-e7ef-b8ca1ae2fd1d@arm.com>
 <CAKwvOdm1kYedukCq=g74AvqJHp6KC03oNoouQy2nkvfo4idoEw@mail.gmail.com>
Message-ID: <CAKwvOdnuKda7paw=GZS5JG-0pGn4-+cWr68m4R+Sd6-=48Uy9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Andrey (who reported testing this patch in
https://github.com/ClangBuiltLinux/linux/issues/11)
On Fri, May 18, 2018 at 10:40 AM Nick Desaulniers <ndesaulniers@google.com>
wrote:

> On Fri, May 18, 2018 at 10:30 AM Marc Zyngier <marc.zyngier@arm.com>
wrote:
> > I'm going to ask the question I've asked before when this patch cropped
> > up (must be the 4th time now):

> > Is it guaranteed that this is the only case where LLVM/clang is going to
> > generate absolute addresses instead of using relative addressing?

> It seems like if there's requirements that only relative addressing be
> used, then the compiler should be told explicitly about this restriction,
> no?
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
