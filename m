From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Sep 2012 15:52:25 +0000
Subject: [PATCH 04/16] ARM: imx: move platform_data definitions
In-Reply-To: <Pine.LNX.4.64.1209111624240.22084@axis700.grange>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <201209111410.05698.arnd@arndb.de>
 <Pine.LNX.4.64.1209111624240.22084@axis700.grange>
Message-ID: <201209121552.26004.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 September 2012, Guennadi Liakhovetski wrote:
> ipu.h is used by the dmaengine and IRQ driver under drivers/dma/ipu/, and 
> by its users drivers/media/platform/soc_camera/mx3_camera.c and 
> drivers/video/mx3fb.c. It has been placed under arch/arm/... because it's 
> arch-specific, but in principle I don't see any reason why it cannot 
> happily live anywhere under include/...

Right. We can do that as the next step, after the pure platform data is
out of the way.

	Arnd
