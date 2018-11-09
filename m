From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Fri, 9 Nov 2018 15:51:15 +0530
Subject: [PATCH v7 2/2] ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE
 PMU driver
In-Reply-To: <84978a48-bd25-eede-519a-a4e9991c5c3d@infradead.org>
References: <20181025055833.28471-1-ganapatrao.kulkarni@cavium.com>
 <20181025055833.28471-3-ganapatrao.kulkarni@cavium.com>
 <84978a48-bd25-eede-519a-a4e9991c5c3d@infradead.org>
Message-ID: <CAKTKpr5mtSuRLfaGe+nQOsEYSP7MghsxhjtVgKmR=jAnrAn1Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 9:42 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/24/18 10:59 PM, Kulkarni, Ganapatrao wrote:
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index 08ebaf7cca8b..c1956b1af2bb 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -87,6 +87,15 @@ config QCOM_L3_PMU
> >          Adds the L3 cache PMU into the perf events subsystem for
> >          monitoring L3 cache events.
> >
> > +config THUNDERX2_PMU
> > +        tristate "Cavium ThunderX2 SoC PMU UNCORE"
> > +     depends on ARCH_THUNDER2 && ARM64 && ACPI && NUMA
> > +        default m
> > +     help
> > +       Provides support for ThunderX2 UNCORE events.
> > +       The SoC has PMU support in its L3 cache controller (L3C) and
> > +       in the DDR4 Memory Controller (DMC).
> > +
> >  config XGENE_PMU
> >          depends on ARCH_XGENE
> >          bool "APM X-Gene SoC PMU"
>
> Please fix the Kconfig indentation.  Use one tab (not spaces) for each of
> tristate, depends, default, and help.  (yes, some of them are tabs and some
> are spaces.)

thanks, i will update.
>
>
> --
> ~Randy

thanks
Ganapat
