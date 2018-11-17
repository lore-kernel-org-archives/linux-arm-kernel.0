From: olof@lixom.net (Olof Johansson)
Date: Fri, 16 Nov 2018 18:55:41 -0800
Subject: [PATCH v2] arm64: sysreg: fix sparse warnings
In-Reply-To: <20181117022748.GC2470@brain-police>
References: <20181116182130.4327-1-geomatsi@gmail.com>
 <20181117022748.GC2470@brain-police>
Message-ID: <CAOesGMia+dFrDpPnV=7tvhCZtBzD-zc_=oDpz4K+BUfCke1wZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 6:28 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Nov 16, 2018 at 09:21:30PM +0300, Sergey Matyukevich wrote:
> > Specify correct type for the constants to avoid
> > the following sparse complaints:
> >
> > ./arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > ./arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> >
> > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> > ---
>
> I still think this is bogus, but the warning is clearly irritating so:
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> Catalin, can you pick this up please?

I missed this when searching and reposted a copy. So feel free to also:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
