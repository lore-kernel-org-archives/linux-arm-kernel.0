From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 28 Jul 2014 08:40:52 +0530
Subject: [PATCH v7 3/4] ARM: EXYNOS: Add platform driver support for Exynos
 PMU
In-Reply-To: <53D238E1.3030901@gmail.com>
References: <1404878455-31518-1-git-send-email-pankaj.dubey@samsung.com>
 <1404878455-31518-4-git-send-email-pankaj.dubey@samsung.com>
 <067501cfa7bd$8e6cb460$ab461d20$@samsung.com>
 <000501cfa7c9$e59f4840$b0ddd8c0$@samsung.com> <53D238E1.3030901@gmail.com>
Message-ID: <002601cfaa11$93de5060$bb9af120$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Friday, July 25, 2014 Tomasz Figa wrote:

> To: Pankaj Dubey; 'Kukjin Kim'; linux-arm-kernel at lists.infradead.org;
linux-
> samsung-soc at vger.kernel.org; linux-kernel at vger.kernel.org
> Cc: linux at arm.linux.org.uk; t.figa at samsung.com; vikas.sajjan at samsung.com;
> joshi at samsung.com; naushad at samsung.com; thomas.ab at samsung.com;
> chow.kim at samsung.com
> Subject: Re: [PATCH v7 3/4] ARM: EXYNOS: Add platform driver support for
> Exynos PMU
> 
> Hi Pankaj, Kukjin,
> 
> On 25.07.2014 07:32, Pankaj Dubey wrote:
> > Hi Kukjin,
> >
> > On Friday, July 25, 2014 Kukjin Kim wrote:
> 
> [snip]
> 
> >>>
> >> Looks good to me, will apply this and 4/4.
> >>
> >
> > We need to hold these two patches until dependent patch [1] from
> > Tomasz Figa gets merged.
> >
> > [1]: mfd: syscon: Decouple syscon interface from syscon devices
> >       https://lkml.org/lkml/2014/6/24/188
> 
> That RFC patch had few comments from Arnd needed to be addressed, so it
needs a
> new revision.
> 
> Pankaj, If I remember correctly, we had talked about this and the
conclusion was that
> you would take care of addressing the comments and sending new version of
the
> patch. Any update on this or have I missed something?
> 

Well, I don't think we concluded as such anything.
Since this patch needs to get in so that Exynos PMU and PM related changes
can go in,
I discussed with you saying that I am not able to understand about Arnd's
comments and
if possible and time permits I will look into it. Meanwhile I got busy with
some other
official work, so could not get time to look into it.


> Best regards,
> Tomasz
