From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 16:56:21 +0200
Subject: [PATCH defconfig] ARM: add ARM_SINGLE_ARMV7M in ARMv7-M defconfigs
In-Reply-To: <20150521082604.GZ24769@pengutronix.de>
References: <1432161501-2323-1-git-send-email-stefan@agner.ch>
 <20150521082604.GZ24769@pengutronix.de>
Message-ID: <10931476.klXfLPFTLM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 10:26:04 Uwe Kleine-K?nig wrote:
> 
> On Thu, May 21, 2015 at 12:38:21AM +0200, Stefan Agner wrote:
> > Select ARM_SINGLE_ARMV7M in defconfigs of the converted ARMv7-M
> > platforms.
> I assume this relates to your series that introduces this symbol. Should
> the defconfig update happen before? (Or what is the result if
> CONFIG_ARM_SINGLE_ARMV7M=y is missing in the defconfig while the symbol
> already exists?) Maybe this should be squashed into the commit in
> question?
> 

I've folded the efm32_defconfig change into the patch that introduces
the ARM_SINGLE_ARMV7M symbol now, to avoid bisection problems.

	Arnd
