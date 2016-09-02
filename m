From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Sep 2016 18:26:42 +0200
Subject: [GIT PULL 1/4] ARM: exynos: SoC/Mach for v4.9
In-Reply-To: <1472548739-20050-5-git-send-email-k.kozlowski@samsung.com>
References: <1472548739-20050-1-git-send-email-k.kozlowski@samsung.com>
 <1472548739-20050-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5635206.ooNAZCeQOe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 30, 2016 11:18:59 AM CEST Krzysztof Kozlowski wrote:
> Samsung mach/soc update for v4.9:
> 1. Fix for DMA on S3C24xx. This was probably broken for long time, nobody runs
>    this code... till now.

Good to know. This reminds me that the s3c24xx DMA code is one of those
that need to be converted to dma_slave_map at some point. Maybe if someone
is now running that code, they could give that a try as well?

It shouldn't be hard to convert, let me know if you need more information.

> 2. After fixes from Matthew Leach and Ben Dooks, most of our mach code
>    and drivers is now endian-safe. Mark the platform as supporting big endian.
> 3. Cleanups.
> 
> 

Pulled into next/soc, thanks!

	Arnd
