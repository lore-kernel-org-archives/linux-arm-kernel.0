From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 20 Sep 2012 10:28:53 +0900
Subject: [PATCH V4] ARM: EXYNOS5: Add bus clock and set parent clock for
 FIMD
In-Reply-To: <04f401cd94c0$6a13da10$3e3b8e30$@org>
References: <1347892995-17924-1-git-send-email-l.krishna@samsung.com>
 <002001cd94bc$05177bc0$0f467340$%han@samsung.com>
 <04f401cd94c0$6a13da10$3e3b8e30$@org>
Message-ID: <006e01cd96cf$4bfb75e0$e3f261a0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 17, 2012 7:37 PM Kukjin Kim wrote
> 
> Jingoo Han wrote:
> >
> > On Monday, September 17, 2012 11:43 PM Leela Krishna Amudala wrote
> > >
> > > This patch adds the bus clock for FIMD and changes the device name for
> > lcd clock
> > > also sets mout_mpll_user as parent clock to fimd
> > >
> > > Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> >
> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> >
> In this case, since Leela addressed comments from you, seems it should be
> 'Reviewed-by'?
> 

According to 'Documentation/SubmittingPatches',

402 Acked-by: is often used by the maintainer of the affected code when that
403 maintainer neither contributed to nor forwarded the patch.

I just use 'Acked-by' as Samsung Framebuffer maintainer, because
this patch affects Samsung Framebuffer driver directly.

Good luck.
