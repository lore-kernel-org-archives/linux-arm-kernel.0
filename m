From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 14 Feb 2011 17:59:21 +0530
Subject: [PATCH v2 4/7] omap: dpll: Add allow_idle/deny_idle support for
	all DPLL's
In-Reply-To: <alpine.DEB.2.00.1102121727140.21991@utopia.booyaka.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
	<1297329400-5936-2-git-send-email-rnayak@ti.com>
	<1297329400-5936-3-git-send-email-rnayak@ti.com>
	<1297329400-5936-4-git-send-email-rnayak@ti.com>
	<1297329400-5936-5-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1102121727140.21991@utopia.booyaka.com>
Message-ID: <813a909da6bafa7ce0c15fa77d9d25b9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Sunday, February 13, 2011 5:58 AM
> To: Rajendra Nayak
> Cc: linux-omap at vger.kernel.org; b-cousson at ti.com; khilman at ti.com;
santosh.shilimkar at ti.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2 4/7] omap: dpll: Add allow_idle/deny_idle support
for all DPLL's
>
> On Thu, 10 Feb 2011, Rajendra Nayak wrote:
>
> > All OMAP3/4 dpll's support hardware level autogating.
> > Populate allow_idle/deny_idle function pointers for all
> > DPLL's in clkops.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
> Thanks, queued for 2.6.39.  Two questions though.  Was the OMAP4
> autogeneration script updated?  Also, any technical reason why you
didn't
> add the OMAP2 DPLL?

Yes, the autogen scripts are updated, however they are
currently in a separate branch (dpll-gatectrl).
Will merge them into master soon.

No real reason for not adding OMAP2 dpll autoidle support.
Its just that I started off trying to do this for OMAP4, and
then found me touching some omap3 stuff and hence
also did it for OMAP3.(For some reason I thought there
were no DPLL's in OMAP2).

Regards,
Rajendra

>
>
> - Paul
