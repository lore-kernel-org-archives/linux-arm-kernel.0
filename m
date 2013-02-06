From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 6 Feb 2013 12:55:03 -0500 (EST)
Subject: [PATCH v4 15/15] ARM: vexpress: Select multi-cluster SMP operation
 if required
In-Reply-To: <1360168718.4045.18.camel@hornet>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-16-git-send-email-nicolas.pitre@linaro.org>
 <1360168718.4045.18.camel@hornet>
Message-ID: <alpine.LFD.2.02.1302061254370.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Feb 2013, Pawel Moll wrote:

> On Tue, 2013-02-05 at 05:22 +0000, Nicolas Pitre wrote:
> > From: Jon Medhurst <tixy@linaro.org>
> > 
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-vexpress/core.h    |  2 ++
> >  arch/arm/mach-vexpress/platsmp.c | 12 ++++++++++++
> >  arch/arm/mach-vexpress/v2m.c     |  2 +-
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> For this and the other "ARM: vexpress" patches in the series:
> 
> Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks.


Nicolas
