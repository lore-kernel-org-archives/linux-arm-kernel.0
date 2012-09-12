From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 12 Sep 2012 16:42:06 -0400 (EDT)
Subject: [PATCH v9 00/13] Per sub-architecture SMP operations
In-Reply-To: <1347461906-13527-1-git-send-email-arnd@arndb.de>
References: <1347461906-13527-1-git-send-email-arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1209121635560.28681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Sep 2012, Arnd Bergmann wrote:

> As I promised at the ARM mini summit, I've updated Marc's series
> for smp operations according to my complaints. Unfortunately,
> I could not find version 7 of the patches when I started this,
> so I based my work on version 6 and had to redo the same
> changes.
> 
> The patches are also available on
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git testing/smp_ops

There are still minor details nagging me, although I did mention them in 
my previous review of this series.  You might have disagreed if I 
remember correctly.  They aren't fundamental, and my insisting on them 
would only be bikeshedding at this point. Therefore you can add my ACK.

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
