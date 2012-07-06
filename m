From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Jul 2012 15:01:42 +0000
Subject: [alsa-devel] DT support for Davinci ASoC platform
In-Reply-To: <4FF5BB34.9070002@gmail.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA35352@DBDE01.ent.ti.com>
 <201207051536.45920.arnd@arndb.de> <4FF5BB34.9070002@gmail.com>
Message-ID: <201207061501.42204.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 July 2012, Daniel Mack wrote:
> > 
> > None of the dma engines are ported yet, because the generic binding for dma
> > engines is still under debate. So far, all DMA channels are described using
> > auxdata on platforms that use DT, with the exception of exynos, but that one
> > will have to change once we have the common code.
> 
> You're talking about the DT bindings here, right? But the code itself is
> also only present in TI's BSP kernel sources, and not in mainline.

Right, I was misreading the question, sorry for the noise.

	Arnd
