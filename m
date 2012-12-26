From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Dec 2012 08:53:50 +0000
Subject: [PATCH v4 3/5] ARM: EXYNOS: Add support for Exynos secure firmware
In-Reply-To: <CAGsJ_4yjm-CE6iJC+pAT=aiNAf0dpANH49e2OD+CqBG+JveGfQ@mail.gmail.com>
References: <1353599478-24617-1-git-send-email-t.figa@samsung.com>
 <1353599478-24617-4-git-send-email-t.figa@samsung.com>
 <CAGsJ_4yjm-CE6iJC+pAT=aiNAf0dpANH49e2OD+CqBG+JveGfQ@mail.gmail.com>
Message-ID: <201212260853.50852.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 December 2012, Barry Song wrote:
> >       / {
> >               /* ... */
> >
> >               firmware at 0203F000 {
> >                       compatible = "samsung,secure-firmware";
> >                       reg = <0x0203F000 0x1000>;
> >               };
> >
> >               /* ... */
> >       };
> 
> well. amazing, dts is used to describle hardware details, here the
> firmware is just a software and reg is the memory the firmware will
> use. is this something againest the dt rule?
> but it is really simple.

We have for a long time had DT bindings to describe firmware, e.g.
on IBM Power systems, I think this is fine.

	Arnd
