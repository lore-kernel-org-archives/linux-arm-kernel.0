From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 18 Aug 2014 19:42:06 +0200
Subject: [PATCH v7 3/4] ARM: EXYNOS: Add platform driver support for Exynos
 PMU
In-Reply-To: <002601cfaa11$93de5060$bb9af120$@samsung.com>
References: <1404878455-31518-1-git-send-email-pankaj.dubey@samsung.com>
 <53D238E1.3030901@gmail.com> <002601cfaa11$93de5060$bb9af120$@samsung.com>
Message-ID: <2491338.uD82s4TcKJ@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, July 28, 2014 08:40:52 AM Pankaj Dubey wrote:
> Hi Tomasz,
> 
> On Friday, July 25, 2014 Tomasz Figa wrote:
> 
> > To: Pankaj Dubey; 'Kukjin Kim'; linux-arm-kernel at lists.infradead.org;
> linux-
> > samsung-soc at vger.kernel.org; linux-kernel at vger.kernel.org
> > Cc: linux at arm.linux.org.uk; t.figa at samsung.com; vikas.sajjan at samsung.com;
> > joshi at samsung.com; naushad at samsung.com; thomas.ab at samsung.com;
> > chow.kim at samsung.com
> > Subject: Re: [PATCH v7 3/4] ARM: EXYNOS: Add platform driver support for
> > Exynos PMU
> > 
> > Hi Pankaj, Kukjin,
> > 
> > On 25.07.2014 07:32, Pankaj Dubey wrote:
> > > Hi Kukjin,
> > >
> > > On Friday, July 25, 2014 Kukjin Kim wrote:
> > 
> > [snip]
> > 
> > >>>
> > >> Looks good to me, will apply this and 4/4.
> > >>
> > >
> > > We need to hold these two patches until dependent patch [1] from
> > > Tomasz Figa gets merged.
> > >
> > > [1]: mfd: syscon: Decouple syscon interface from syscon devices
> > >       https://lkml.org/lkml/2014/6/24/188
> > 
> > That RFC patch had few comments from Arnd needed to be addressed, so it
> needs a
> > new revision.
> > 
> > Pankaj, If I remember correctly, we had talked about this and the
> conclusion was that
> > you would take care of addressing the comments and sending new version of
> the
> > patch. Any update on this or have I missed something?
> > 
> 
> Well, I don't think we concluded as such anything.
> Since this patch needs to get in so that Exynos PMU and PM related changes
> can go in,
> I discussed with you saying that I am not able to understand about Arnd's
> comments and
> if possible and time permits I will look into it. Meanwhile I got busy with
> some other
> official work, so could not get time to look into it.

Tomasz/Pankaj, could we please get some agreement on what needs to be
done and who should do the pending work?

syscon patch is blocking PMU cleanup patches which in turn are blocking
PMU support additions for new SoCs (Exynos5420/5800 and Exynos3250 PMU
patches).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
