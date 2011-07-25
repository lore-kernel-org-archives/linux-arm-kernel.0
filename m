From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 25 Jul 2011 15:15:32 -0600
Subject: [PATCH V4 14/14] ARM: SAMSUNG: Remove Samsung specific enum type
	for dma direction
In-Reply-To: <CABb+yY3dwshghgXPuMyLzm=ArYdELBOqVf4AcxN77MV1jV8Ang@mail.gmail.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-15-git-send-email-boojin.kim@samsung.com>
	<CABb+yY3dwshghgXPuMyLzm=ArYdELBOqVf4AcxN77MV1jV8Ang@mail.gmail.com>
Message-ID: <20110725211532.GF26735@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 05:38:37PM +0530, Jassi Brar wrote:
> On Mon, Jul 25, 2011 at 6:58 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
> > This patch removes the samsung specific enum type 's3c2410_dmasrc'
> > and uses 'dma_data_direction' instead.
> >
> > Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> 
> If this patch was first in the patchset, probably it could have been
> already merged.

Indeed.  If you move this to the front when you post the next version
then it can be merged right away.

Acked-by: Grant Likely <grant.likely@secretlab.ca>
