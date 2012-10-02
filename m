From: olof@lixom.net (Olof Johansson)
Date: Tue, 2 Oct 2012 09:59:42 -0700
Subject: make dtbs in linus/master
In-Reply-To: <alpine.DEB.2.02.1210021725320.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1210021725320.29232@kaball.uk.xensource.com>
Message-ID: <CAOesGMjy2icwKduijghZ=cq-EMSWewEL+E1mUNySuxngXpHzCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2012 at 9:36 AM, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> Hello,
> I am testing linus/master after the recent merge with the arm-soc tree
> and I find that if I choose:
>
> ARM system type
>   1. Allow multiple platforms to be selected (ARCH_MULTIPLATFORM) (NEW)
>   2. ARM Ltd. Integrator family (ARCH_INTEGRATOR)
>   3. ARM Ltd. RealView family (ARCH_REALVIEW)
>>  4. ARM Ltd. Versatile family (ARCH_VERSATILE)
>
> in my kernel config, then "make dtbs" doesn't work.
> However if I choose ARCH_MULTIPLATFORM then it works properly.
>
> Is it expected?

Yes, because versatile does not list any device tree files to build in
the makefile (arch/arm/boot/dts/Makefile)


-Olof
