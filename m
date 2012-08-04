From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 4 Aug 2012 22:59:38 +0200
Subject: [PATCH] [RFC] arm: add documentation describing Marvell
 families of SoC
In-Reply-To: <CAMPhdO8jiTwfdk0DkhjdwMbH3Mt6=XXZKhwNH412UfNbodu7Ww@mail.gmail.com>
References: <1342535201-12907-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAMPhdO8jiTwfdk0DkhjdwMbH3Mt6=XXZKhwNH412UfNbodu7Ww@mail.gmail.com>
Message-ID: <20120804225938.6d44a9af@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

Thanks for all those details! Some comments below.

Le Wed, 18 Jul 2012 02:01:51 +0800,
Eric Miao <eric.y.miao@gmail.com> a ?crit :

> This is so useful to Marvell processor new comers, thanks everyone to
> compile this.
> 
> The PXA side might need a bit modification though, so for historical
> reason there is PXA series as originated back from Intel. So there
> are really those legacy ones:
> 
>   PXA21x/PXA25x/PXA27x/PXA3xx/PXA93x
> 
> The new ones developed after Marvell acquired Intel's XScale biz are:
> 
>   PXA95x/PXA168/PXA910/MMP2
> 
> And among these, they are actually categorized into two flavors:
> 
>   AP with CP: PXA93x/PXA95X/PXA910
>   AP only without CP: the rest of them
> 
> And the ARM cores used are also a bit different:
> 
>   XScale (Intel's ARMv5te compatible):
> PXA21x/PXA25x/PXA27x/PXA3xx/PXA93x Marvell's PJ1 (Marvell's ARMv5te
> compatible): PXA168/PXA910 Marvell's PJ4 (Marvell's ARMv7
> compatible): PXA95x/MMP2

Great, I included all those informations in some form. Will be part of
v3.

> So these are really a bit complicated, by the end of the day, we
> would still go the way as Arnd suggested, that to collapse PXA and
> MMP series into one, so that will be simpler and easier to understand.
> 
> Considering the complications here, I would suggest to simply have a
> single processor line as: PXA/MMP processor line, and list all the
> processor flavors under, whether it's an AP or a AP+CP could be
> individually indicated.

For now, I prefer to keep those as two separate families, so that it
reflects the *current* state of the Linux mach-* directories. The
current state may not be perfect, but it's the current state, so let's
reflect it for now.

Thanks again for your comments!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
