From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 14 Feb 2011 17:45:36 +0530
Subject: [PATCH 1/7] omap: clock: Check for enable/disable ops support
In-Reply-To: <alpine.DEB.2.00.1102121615130.21991@utopia.booyaka.com>
References: <1297159838-30282-1-git-send-email-rnayak@ti.com>
	<1297159838-30282-2-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1102121615130.21991@utopia.booyaka.com>
Message-ID: <61921a70b7d31d38192210257bca3c0e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Sunday, February 13, 2011 4:48 AM
> To: Rajendra Nayak
> Cc: linux-omap at vger.kernel.org; b-cousson at ti.com; khilman at ti.com;
santosh.shilimkar at ti.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 1/7] omap: clock: Check for enable/disable ops
support
>
> On Tue, 8 Feb 2011, Rajendra Nayak wrote:
>
> > Check if enable/disable operations are supported for a given
> > clock node before attempting to call them.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
> Thanks, queued in branch 'clk_a_2.6.39' of
git://git.pwsan.com/linux-2.6.

This patch seems to be needed in clk_autoidle_a_2.6.39 too,
without which there is an abort at boot on OMAP4.

Regards,
Rajendra

>
> This patch is integrated as part of the tag
> 'tmp-integration-2.6.39-20110212-003' and the branch
'integration-2.6.39'
> of git://git.pwsan.com/linux-integration.
>
>
> - Paul
