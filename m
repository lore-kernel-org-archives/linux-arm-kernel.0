From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 31 Jul 2014 10:10:09 +0900
Subject: [PATCH 0/3] ARM: EXYNOS: Fix Exynos5410 boot
In-Reply-To: <CAOesGMjh=xMZ3vB45ofh=CLjTFDMQxSxus5q_P67XQSbwg6-+A@mail.gmail.com>
References: <1406463725-4208-1-git-send-email-afaerber@suse.de>
 <53D4EFBB.6000404@suse.de> <00c901cfa9fc$727b4e10$5771ea30$@samsung.com>
 <CAOesGMjh=xMZ3vB45ofh=CLjTFDMQxSxus5q_P67XQSbwg6-+A@mail.gmail.com>
Message-ID: <03f501cfac5c$2c69be90$853d3bb0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> Hi,
> 
Hi Olof,

> On Sun, Jul 27, 2014 at 5:39 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Andreas F?rber wrote:
> >>
> >> Am 27.07.2014 14:22, schrieb Andreas F?rber:
> >> > Hello,
> >> >
> >> > This mini-series unbreaks booting on 5410 based ODROID-XU.
> >> >
> >> > Since I do not have access to a TRM, the address is a guess based on
> >> > 5250 and 5410. Such a node was not present in the 3.14 downstream tree.
> >>
> >> s/5410/5420/
> >>
> > OK.
> >
> >> >
> >> > Regards,
> >> > Andreas
> >> >
> >> > Andreas F?rber (3):
> >> >   Documentation: devicetree: Document exynos5410 PMU
> >> >   ARM: dts: exynos: Add PMU to Exynos5410
> >> >   ARM: EXYNOS: Add support for Exynos5410 PMU
> >> >
> >> >  Documentation/devicetree/bindings/arm/samsung/pmu.txt | 1 +
> >> >  arch/arm/boot/dts/exynos5410.dtsi                     | 5 +++++
> >> >  arch/arm/mach-exynos/exynos.c                         | 1 +
> >> >  3 files changed, 7 insertions(+)
> >>
> > Andreas, thanks.
> >
> > I'll apply this whole series.
> 
> We're getting close to the merge window. I'd prefer not to have to
> start reverting samsung code to recover from these regressions, so
> please send this up very soon.
> 
Thanks for your gentle reminder.

BTW I'm waiting for exynos5250-spring support from Andreas and I'd like to get
confirmation about that from Doug. And I'm looking at s2r related patches now.

OK, I will send out current samsung tree tonight in my time anyway.

- Kukjin
