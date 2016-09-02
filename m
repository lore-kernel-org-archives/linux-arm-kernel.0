From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 2 Sep 2016 18:32:44 +0200
Subject: [GIT PULL 1/4] ARM: exynos: SoC/Mach for v4.9
In-Reply-To: <5635206.ooNAZCeQOe@wuerfel>
References: <1472548739-20050-1-git-send-email-k.kozlowski@samsung.com>
 <1472548739-20050-5-git-send-email-k.kozlowski@samsung.com>
 <5635206.ooNAZCeQOe@wuerfel>
Message-ID: <20160902163244.GB5534@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 06:26:42PM +0200, Arnd Bergmann wrote:
> On Tuesday, August 30, 2016 11:18:59 AM CEST Krzysztof Kozlowski wrote:
> > Samsung mach/soc update for v4.9:
> > 1. Fix for DMA on S3C24xx. This was probably broken for long time, nobody runs
> >    this code... till now.
> 
> Good to know. This reminds me that the s3c24xx DMA code is one of those
> that need to be converted to dma_slave_map at some point. Maybe if someone
> is now running that code, they could give that a try as well?
> 
> It shouldn't be hard to convert, let me know if you need more information.

+Cc Sylwester,

Sylwester recently dig into this platform. I think he managed to play
some audio.

Best regards,
Krzysztof
