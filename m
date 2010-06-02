From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jun 2010 23:48:01 +0100
Subject: PB1176 broken in 2.6.35-rc1, bisected
In-Reply-To: <AANLkTikoCy2FH_5ICh-iiI_wzGj6D6oszyM-zCXkNC_4@mail.gmail.com>
References: <AANLkTikoCy2FH_5ICh-iiI_wzGj6D6oszyM-zCXkNC_4@mail.gmail.com>
Message-ID: <20100602224801.GA12604@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 12:33:57AM +0200, Linus Walleij wrote:
> I bisected until I had this as the first commit causing the trouble:
> 
> commit ac1d426e825ab5778995f2f6f053ca2e6b45c622
> Merge: fda0e18 a3685f0
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Mon May 17 17:24:04 2010 +0100
> 
>     Merge branch 'devel-stable' into devel
> 
>     Conflicts:
>         arch/arm/Kconfig
>         arch/arm/include/asm/system.h
>         arch/arm/mm/Kconfig

You should be able to bisect further - did bisect just give up at this
point?

Do you know which half of that merge was also tested?
