From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 00:30:35 +0200
Subject: [GIT PULL] pxa for v4.9
In-Reply-To: <87zinhf0fi.fsf@belgarion.home>
References: <87zinhf0fi.fsf@belgarion.home>
Message-ID: <6127657.SjoUjIm78t@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 9, 2016 7:27:45 PM CEST Robert Jarzmik wrote:
> This is the pxa changes for v4.9 cycle.
> 
> This cycle is covering :
>  - the removal of the legacy DMA API
>    This is the major contributor to the negative diffstat, as dmaengine
>    have taken over in this area.

Very nice!

>  - IDE subsystem defconfig fixes
>  - preparation for pxa25x to be device-tree compliant
>  - various irq related fixes

Pulled into next/soc, thanks!

	Arnd
