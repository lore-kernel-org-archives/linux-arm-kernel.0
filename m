From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 17 Jun 2013 19:13:04 +0530
Subject: MUSB multiplatform work?
In-Reply-To: <CAJe_ZheT6q6YnWU=1_bdwGE4-n9WNJyADFQ_TpQckuVfYai7zw@mail.gmail.com>
References: <201305271702.09203.arnd@arndb.de>
 <20130528163548.GC28253@arwen.pp.htv.fi>
 <20130530201854.GB6467@atomide.com>
 <CACRpkdZHupVFS+pNADpaJjunPa3fEtyCqLwbL-etHs3gt8EW0Q@mail.gmail.com>
 <20130530203132.GC6467@atomide.com>
 <CACRpkdaUegc7B8awUiQTvFRJHPMWv6hEEsE-2AHtZCDXVEMN9g@mail.gmail.com>
 <20130612100542.GV4107@intel.com>
 <CAJe_ZheT6q6YnWU=1_bdwGE4-n9WNJyADFQ_TpQckuVfYai7zw@mail.gmail.com>
Message-ID: <20130617134304.GD10671@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 05:27:53PM +0530, Jassi Brar wrote:
> IIRC,  TI's Sundaram Raju proposed a TI specific api to DMAEngine for
> this very purpose, which was generalized into
> device_prep_interleaved_dma().  Which I think should already be enough
> to serve the purpose. Is it not?
The interleaved for having to get/set data from interleaved or an 2d array.
Think of a raw image from camera where you need to get some region only and skip
rest. In those case interleaved API helps

Here this is just normal slave DMA with changing FIFO address and which just
loops over the FIFO value

--
~Vinod
