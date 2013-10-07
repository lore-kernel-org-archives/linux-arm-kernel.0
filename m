From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 7 Oct 2013 20:13:35 +0530
Subject: [PATCH] DMA: extend documentation to provide more API details
In-Reply-To: <Pine.LNX.4.64.1310071725300.20796@axis700.grange>
References: <20131005190200.GZ12758@n2100.arm.linux.org.uk>
 <Pine.LNX.4.64.1310052203060.8097@axis700.grange>
 <20131005233137.GA12758@n2100.arm.linux.org.uk>
 <20131006052029.GE2954@intel.com>
 <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
 <20131007111728.GM12758@n2100.arm.linux.org.uk>
 <20131007103936.GH2954@intel.com>
 <Pine.LNX.4.64.1310071409080.20796@axis700.grange>
 <20131007142511.GJ2954@intel.com>
 <Pine.LNX.4.64.1310071725300.20796@axis700.grange>
Message-ID: <20131007144335.GL2954@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 05:28:37PM +0200, Guennadi Liakhovetski wrote:
> > > > > > No, not something in the middle. I was thinking about
> > > > > > 
> > > > > > (1) cookie 1-3 are submitted
> > > > > > (2) cookie 1 succeeds
> > > > > > (3) a DMA error occurs, cookies 2-3 are discarded
> > > > discarded using terminate_all right?
> > > 
> > > No, by the dmaengine driver as a part of the error processing.
> > And how will that be done...?
> 
> Sorry, I meant - DMA descriptors with cookies #2 and #3 will be cancelled 
> and recycled by the dmaengine driver. That's what you have to do, when 
> processing DMA error IRQ.
Well how do you that?

--
~Vinod
