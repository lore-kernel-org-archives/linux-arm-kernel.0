From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Tue, 2 Oct 2012 20:47:49 +0000
Subject: [PATCH 2/2] mtd: sh_flctl: Add device tree support
In-Reply-To: <Pine.LNX.4.64.1210021602250.15778@axis700.grange>
References: <1349183522-15321-1-git-send-email-hechtb@gmail.com>
 <201210021354.01247.arnd@arndb.de>
 <Pine.LNX.4.64.1210021602250.15778@axis700.grange>
Message-ID: <201210022047.50064.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 October 2012, Guennadi Liakhovetski wrote:
> > 
> > Since you are also adding dma-engine support, I would suggest you specify
> > a "dmas" and "dma-names" property as well, so the device can find the
> > right dma channel. The code might not do that yet while you're still
> > sorting out the dependencies (and the sh dmaengine code is not yet
> > converted to DT), but I think it would be good to nail down the binding
> > for this device.
> 
> Have DMA DT bindings been accepted yet, are they fixed? Wouldn't it be 
> better to wait until patches appear in a tree, at least with high 
> probability heading towards the mainline, or have they already?
> 

I think they ended up not getting scheduled for 3.7, which is a bit disappointing
after we got an agreement on the binding.  However, I am rather confident that
we won't change the binding again, at least I don't see how they would change
in a way that would impact the binding document for a device using a DMA channel.

	Arnd
