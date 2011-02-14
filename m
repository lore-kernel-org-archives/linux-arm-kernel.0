From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 14 Feb 2011 18:04:46 +0530
Subject: [PATCH v2 7/7] omap4: dpll: Enable auto gate control for all MX
	postdividers
In-Reply-To: <alpine.DEB.2.00.1102121809360.21991@utopia.booyaka.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
	<1297329400-5936-2-git-send-email-rnayak@ti.com>
	<1297329400-5936-3-git-send-email-rnayak@ti.com>
	<1297329400-5936-4-git-send-email-rnayak@ti.com>
	<1297329400-5936-5-git-send-email-rnayak@ti.com>
	<1297329400-5936-6-git-send-email-rnayak@ti.com>
	<1297329400-5936-7-git-send-email-rnayak@ti.com>
	<1297329400-5936-8-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1102121809360.21991@utopia.booyaka.com>
Message-ID: <d91c419d34c18bc45915b50cefccaa9d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Sunday, February 13, 2011 6:41 AM
> To: Rajendra Nayak
> Cc: linux-omap at vger.kernel.org; b-cousson at ti.com; khilman at ti.com;
santosh.shilimkar at ti.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2 7/7] omap4: dpll: Enable auto gate control for
all MX postdividers
>
> On Thu, 10 Feb 2011, Rajendra Nayak wrote:
>
> > Enable hardware gate control for all dpll MX and X2 postdividers.
> > This requires the allow_idle/deny_idle functions to be
> > populated for all clock nodes (mx/x2 post dividers) in
> > clkops.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
> Thanks, queued for 2.6.39 in the 'clk_autoidle_a_2.6.39' branch.  Has
the
> OMAP4 clock data autogenerator script been updated?

Yes, the autogen scripts are updated. Will merge the changes
in master.

Regards,
Rajendra
>
>
> - Paul
