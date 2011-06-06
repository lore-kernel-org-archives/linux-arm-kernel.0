From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Mon, 6 Jun 2011 17:06:01 +0900
Subject: [PATCH 1/3] dmaengine: add new dma API for max_segment_number
In-Reply-To: <20110606065419.GA20904@S2100-06.ap.freescale.net>
References: <1307338118.10976.74.camel@vkoul-udesk3>
	<20110606153634D.fujita.tomonori@lab.ntt.co.jp>
	<20110606065419.GA20904@S2100-06.ap.freescale.net>
Message-ID: <20110606163913U.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jun 2011 14:54:21 +0800
Shawn Guo <shawn.guo@freescale.com> wrote:

> On Mon, Jun 06, 2011 at 03:38:12PM +0900, FUJITA Tomonori wrote:
> > On Mon, 06 Jun 2011 10:58:38 +0530
> > "Koul, Vinod" <vinod.koul@intel.com> wrote:
> > 
> > > On Sun, 2011-06-05 at 10:30 +0900, FUJITA Tomonori wrote:
> > > > On Wed, 1 Jun 2011 10:33:57 +0800
> > > > Shawn Guo <shawn.guo@freescale.com> wrote:
> > > > 
> > > > > On Thu, May 26, 2011 at 02:31:31PM +0800, Shawn Guo wrote:
> > > > > > Like dma_set(get)_max_seg_size for max_segment_size, the patch adds
> > > > > > max_segment_number into device_dma_parameters and creates the
> > > > > > corresponding dmaengine API dma_set(get)_max_seg_number for it.
> > > > > > 
> > > > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > > > > ---
> > > > > >  include/linux/device.h      |    1 +
> > > > > >  include/linux/dma-mapping.h |   15 +++++++++++++++
> > > > > >  2 files changed, 16 insertions(+), 0 deletions(-)
> > > > 
> > > > include/linux/dma-mapping.h is for DMA mapping API (please see
> > > > Documentation/DMA-API*.txt).
> > > > 
> Hmm, I think they are all about dmaengine.

No, I added them for the DMA mapping API (mainly, IOMMUs).
