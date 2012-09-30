From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Sep 2012 20:55:03 -0700
Subject: [GIT PULL] ARM: mvebu: cache-l2x0 DT for v3.7
In-Reply-To: <20120930015012.GB17765@titan.lakedaemon.net>
References: <20120930015012.GB17765@titan.lakedaemon.net>
Message-ID: <20120930035503.GB477@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 29, 2012 at 09:50:12PM -0400, Jason Cooper wrote:
> Depends:
>  - Based on arm-soc/late/kirkwood
>  - Patches going through rmk's patch tracker:
>     - arm: cache-l2x0: make outer_cache_fns a field of l2x0_of_data
>     - arm: cache-l2x0: add an optional register to save/restore
>     - arm: cache-l2x0: add support for Aurora L2 cache ctrl
> 
>     - feature-use dependency only.  No build breakage or failed boot
>       should occur.  Until patches from rmk's tracker land, driver
>       won't know about compatible property, so it's like the driver
>       isn't there.
> 
> Adds:
>  - cache-l2x0 DT entry for Marvell Armada (mvebu) SoCs

Hi Jason,

I'd prefer to hold off on this until we know that Russell is happy with
the l2x0 changes, just in case this part of the series might need revising
(i.e.  bindings changes). Please resend when he has picked them up!


Thanks,

-Olof
