From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 20 Sep 2011 14:06:26 -0400 (EDT)
Subject: [GIT PULL] ux500-core for 3.2
In-Reply-To: <CACRpkdZofKjOrPFWNR-2D0LWx3NGMiLwyhf7gAVdvBGvQHqJLQ@mail.gmail.com>
References: <CACRpkdZofKjOrPFWNR-2D0LWx3NGMiLwyhf7gAVdvBGvQHqJLQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1109201403040.12663@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Sep 2011, Linus Walleij wrote:

> Hi Arnd,
> 
> could you please pull:
> 
> git://git.linaro.org/people/triad/linux-stericsson.git for-arnd

[...]

> Barry Song (1):
>       ARM: mach-ux500: add explicit cpu_relax() for busy wait loop
> 
> Fredrik Svensson (1):
>       mach-ux500: remove pull-pinconfig and add SPI2
> 
> Lee Jones (1):
>       mach-ux500: remove most of the ugly machine_is_*() calls
> 
> Linus Walleij (2):
>       mach-ux500: factor out l2x0 handling code
>       mach-ux500: unlock I&D l2x0 caches before init
> 
> srinidhi kasagar (1):
>       mach-ux500: enable fix for ARM errata 754322

Please try to include the "ARM: " prefix (or ask the people you merge 
from) in all the patch titles.  Once in mainline with all the other 
stuff this helps others making sense of the log summaries.

no need to redo this lot though.


Nicolas
