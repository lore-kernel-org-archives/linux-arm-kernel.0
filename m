From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 16 Jul 2010 16:47:07 +0200
Subject: [PATCH 01/10 v2] ARM: Samsung: Add FIMC register and platform
	definitions
In-Reply-To: <4C40603B.8000208@gmail.com>
References: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
	<1279185041-6004-2-git-send-email-s.nawrocki@samsung.com>
	<012101cb24cb$83187410$89495c30$%kim@samsung.com>
	<000301cb24eb$13434000$39c9c000$%nawrocki@samsung.com>
	<4C40603B.8000208@gmail.com>
Message-ID: <000801cb24f5$c3377490$49a65db0$%nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Maurus Cuelenaere [mailto:mcuelenaere at gmail.com]
> Sent: Friday, July 16, 2010 3:36 PM
> To: Sylwester Nawrocki
> Cc: 'Kukjin Kim'; Pawel Osciak; Marek Szyprowski;
> kyungmin.park at samsung.com; linux-media at vger.kernel.org; linux-samsung-
> soc at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 01/10 v2] ARM: Samsung: Add FIMC register and
> platform definitions
> 
>  Op 16-07-10 15:30, Sylwester Nawrocki schreef:
> > Hi,
> >
> > thank you for the review. Please se my comments below.
> >
> >> -----Original Message-----
> >> From: Kukjin Kim [mailto:kgene.kim at samsung.com]
> >> Sent: Friday, July 16, 2010 11:45 AM
> >> To: 'Sylwester Nawrocki'; linux-samsung-soc at vger.kernel.org; linux-
> arm-
> >> kernel at lists.infradead.org
> >> Cc: p.osciak at samsung.com; m.szyprowski at samsung.com;
> >> kyungmin.park at samsung.com; linux-media at vger.kernel.org
> >> Subject: RE: [PATCH 01/10 v2] ARM: Samsung: Add FIMC register and
> >> platform definitions
> >>

<snip>

> >>> +
> >>> +struct samsung_plat_fimc {
> >>> +	struct s3c_fifo_link	*fifo_targets[FIMC_MAX_FIFO_TARGETS];
> >>> +};
> >>> +
> >>> +#endif /* FIMC_H_ */
> >>> +
> >> No need last empty line...
> > C89 and C99 standard requires a new line character at the end of
> file.
> > The compiler should issue a warning when the new line character
> > at the end of file is missing, otherwise it is not compliant with
> > the above C standards.
> > So I would rather add a new line where it is missing rather than
> > removing it.
> > There is lots of header files already in arch/arm/plat-samsung where
> > there is even more than one empty line at the end of file.
> 
> AFAIK there *already is* an empty line, git just omits it in diffs.
> Try removing the last line with your editor and see what git diff
> gives, it'll
> show "\ No newline at end of file".

Indeed, I just had two new-line characters with single empty line..

> 
> --
> Maurus Cuelenaere

Thanks,
Sylwester
