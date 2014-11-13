From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 13 Nov 2014 10:19:31 +0000
Subject: [PATCH 0/2] dma: pl330: Fixes for DMA memcpy
In-Reply-To: <20141112093158.GB24582@intel.com>
References: <1415383518-29327-1-git-send-email-tixy@linaro.org>
 <20141112093158.GB24582@intel.com>
Message-ID: <1415873971.1725.2.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-11-12 at 15:01 +0530, Vinod Koul wrote:
> On Fri, Nov 07, 2014 at 06:05:16PM +0000, Jon Medhurst wrote:
> > This is a couple of patches I produced when trying to get dmatest to run
> > with the pl330 driver. The second one is actually a theoretical fix
> > because the FIFO on the platform I was using is too large for the tests
> > to hit the limit, but the datasheet says the device can lockup if all
> > the FIFO entries are exhausted, so it seems like a sensible precaution.
> >
> Applied, thanks
>
> Please ensure you use the right subsystem name for the patch header

I originally created the patch when working on Linux 3.14 and most
previous updates to the file used 'dma', I see now in recent versions
that the preferred name is 'dmaengine' (and matches the mailing list
name) so will use that in future.

BTW, though I was working on 3.14 I have retested the patches on a
3.18-rc

-- 
Tixy
