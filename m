From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 28 Jul 2011 10:23:18 +0900
Subject: [PATCH V4 14/14] ARM: SAMSUNG: Remove Samsung specific enum type
	for dma direction
In-Reply-To: <20110725211532.GF26735@ponder.secretlab.ca>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-15-git-send-email-boojin.kim@samsung.com>
	<CABb+yY3dwshghgXPuMyLzm=ArYdELBOqVf4AcxN77MV1jV8Ang@mail.gmail.com>
	<20110725211532.GF26735@ponder.secretlab.ca>
Message-ID: <001401cc4cc4$ef557d40$ce0077c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely Wrote:
> Likely
> Sent: Tuesday, July 26, 2011 6:16 AM
> To: Jassi Brar
> Cc: Boojin Kim; linux-arm-kernel at lists.infradead.org; linux-samsung-
> soc at vger.kernel.org; Vinod Koul; Dan Williams; Kukjin Kim; Mark Brown
> Subject: Re: [PATCH V4 14/14] ARM: SAMSUNG: Remove Samsung specific
> enum type for dma direction
>
> On Mon, Jul 25, 2011 at 05:38:37PM +0530, Jassi Brar wrote:
> > On Mon, Jul 25, 2011 at 6:58 AM, Boojin Kim <boojin.kim@samsung.com>
> wrote:
> > > This patch removes the samsung specific enum type 's3c2410_dmasrc'
> > > and uses 'dma_data_direction' instead.
> > >
> > > Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> > > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >
> > Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> >
> > If this patch was first in the patchset, probably it could have been
> > already merged.
>
> Indeed.  If you move this to the front when you post the next version
> then it can be merged right away.
I tried to move it ahead. But It made some conflicts.
So, I pushed as it is on V5 release.
Sorry.. I would have noticed it before I release V5.

>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
