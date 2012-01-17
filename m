From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Jan 2012 10:53:15 +0000
Subject: [GIT PULL] Samsung devel for v3.3
In-Reply-To: <CAOesGMiU+-wfxsfha7GTO3s7dHysP65gcrbJsLWhBpZNT9O+UQ@mail.gmail.com>
References: <018801ccca70$25f01260$71d03720$%kim@samsung.com>
 <CAOesGMhLE3wxM=F9OkHT-bQpsVp8Uc6eE8Uk+WN9pLuz5BRLBw@mail.gmail.com>
 <20120108204953.GA20043@sirena.org.uk>
 <CAOesGMjn5uQEWbxrJryC+jOf=3SYbAnPY4A71NUZKFBi=a0QjA@mail.gmail.com>
 <20120109082640.GI22134@opensource.wolfsonmicro.com>
 <CAOesGMiU+-wfxsfha7GTO3s7dHysP65gcrbJsLWhBpZNT9O+UQ@mail.gmail.com>
Message-ID: <20120117105315.GB2944@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2012 at 10:40:17PM -0800, Olof Johansson wrote:

> The above two don't seem to have been in the branch that was sent by
> Kukjin, it had:

>       ARM: EXYNOS: Invert VCLK polarity for framebuffer on ORIGEN
>       ARM: S3C64XX: Fix interrupt configuration for PCA935x on Cragganmore
>       ARM: S3C64XX: Fix the memory mapped GPIOs on Cragganmore
>       ARM: S3C64XX: Remove hsmmc1 from Cragganmore
>       ARM: S3C64XX: Remove unconditional power domain disables
>       ARM: SAMSUNG: Declare struct platform_device in plat/s3c64xx-spi.h
>       ARM: SAMSUNG: dma-ops.h needs mach/dma.h
>       ARM: SAMSUNG: Guard against multiple inclusion of plat/dma.h

> I've pulled the branch from him.

I applied all the fixes I was sitting on that were in -next only at the
time I looked; stuff like this is part of the reason why I tend to avoid
topic branches unless they're likely to get merged in multiple places,
too much bookkeeping.
