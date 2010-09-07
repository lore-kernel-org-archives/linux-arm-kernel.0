From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 8 Sep 2010 02:10:05 +0300
Subject: [PATCH 1/3] rx1950: add battery device
In-Reply-To: <4C86C56B.7090204@fluff.org>
References: <1283869946-28296-1-git-send-email-anarsoul@gmail.com>
	<1283869946-28296-2-git-send-email-anarsoul@gmail.com>
	<4C86C56B.7090204@fluff.org>
Message-ID: <201009080210.12621.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 8 ???????? 2010 02:06:19 ????? Ben Dooks ???????:
> On 07/09/10 15:32, Vasily Khoruzhick wrote:
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> > 
> >  arch/arm/mach-s3c2440/Kconfig       |    3 +
> >  arch/arm/mach-s3c2440/mach-rx1950.c |  160
> >  +++++++++++++++++++++++++++++++++++ 2 files changed, 163 insertions(+),
> >  0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-s3c2440/Kconfig
> > b/arch/arm/mach-s3c2440/Kconfig index cd8e7de..9b6b026 100644
> > --- a/arch/arm/mach-s3c2440/Kconfig
> > +++ b/arch/arm/mach-s3c2440/Kconfig
> > @@ -198,6 +198,9 @@ config MACH_RX1950
> > 
> >  	select S3C_DEV_NAND
> >  	select S3C2410_IOTIMING if S3C2440_CPUFREQ
> >  	select S3C2440_XTAL_16934400
> > 
> > +	select S3C_ADC
> > +	select PDA_POWER
> > +	select BATTERY_S3C_ADC
> 
> not keen on forcing these on unless they are required for the
> system to work.

Ok

> > +	{3629, 178, 10},
> > +	{3612, 162, 5},
> > +	{3605, 162, 0},
> > +
> 
> at least add a space after { and before }
> it would be nice to have named initialisers.

Ok, I'll add named initialisers

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100908/c04cdb87/attachment.sig>
