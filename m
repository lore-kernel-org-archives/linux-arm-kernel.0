From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 24 Jul 2013 16:36:29 +0900
Subject: [PATCH V2 2/2] ARM: EXYNOS: cpuidle: Allow C1 state only in
 supported SOC's.
In-Reply-To: <CADGdYn5uY7A9OB=xGi_oKS3DX6+wRhbKBnTfxjkFY5OtUX3hXg@mail.gmail.com>
References: <1371036526-16589-1-git-send-email-amit.daniel@samsung.com>
 <1371036526-16589-3-git-send-email-amit.daniel@samsung.com>
 <0e2301ce882c$d39021a0$7ab064e0$@org>
 <CADGdYn5uY7A9OB=xGi_oKS3DX6+wRhbKBnTfxjkFY5OtUX3hXg@mail.gmail.com>
Message-ID: <0e7d01ce8840$82f79070$88e6b150$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

amit daniel kachhap wrote:

[...]

> >>               /* Support IDLE only */
> >> -             if (cpu_id != 0)
> >> +             if (!(soc_is_exynos4210() || soc_is_exynos4212() ||
> >> +                     soc_is_exynos4412() || soc_is_exynos5250()) ||
> >> +                     cpu_id != 0)
> >
> > How about exynos5420?
> >
> > So...
> >
> > +               if (soc_is_exynos5440() || cpu_id !=0) ?
> This is fine.
> 
So, you will re-send?

- Kukjin
