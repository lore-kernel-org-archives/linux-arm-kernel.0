From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Feb 2011 12:07:10 +0530
Subject: [PATCH v2 3/9] omap4: powerdomain: Use intended PWRSTS_* flags
	instead of values
In-Reply-To: <alpine.DEB.2.00.1102071845140.21991@utopia.booyaka.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
	<1296813544-25170-4-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1102071845140.21991@utopia.booyaka.com>
Message-ID: <8dcdd90dcde5ddefc02b08dc2faf9169@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Tuesday, February 08, 2011 7:16 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; khilman at ti.com; b-cousson at ti.com;
> rnayak at ti.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 3/9] omap4: powerdomain: Use intended
> PWRSTS_* flags instead of values
>
> On Fri, 4 Feb 2011, Santosh Shilimkar wrote:
>
> > IVAHD and ABE power domain logic state is populated using directly
> > value instead of the capability flags.
> >
> > Fix the same.
> >
> > This was getting generated due to a bug 'gen_logicst' macro
> > in powerdomain autogen script bug which is fixed as well.
>
> Should we try to get this one into the -rc series, since it is a
> bug-fix ?
>
Make sense.
