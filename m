From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jun 2017 23:33:01 +0200
Subject: [PATCH] bus: SIMPLE_PM_BUS does not depend on ARCH_RENESAS
In-Reply-To: <20170613130430.4272-1-robdclark@gmail.com>
References: <20170613130430.4272-1-robdclark@gmail.com>
Message-ID: <CAK8P3a1v=3X3t9VE_my1jBH0Wo14FYMF9+ijFw8kHLDVjZ4meQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 3:04 PM, Rob Clark <robdclark@gmail.com> wrote:
> In fact, it is needed for PCI to work on msm8996 (and probably other
> things).  No idea why it was depending on renesas but that doesn't make
> any sense.  So drop the dependency.
>
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---

I also couldn't find a reason why this was strictly limited, but it in
the device
tree sources we ship in the kernel, it is so far only used for Renesas machines,
so it's not currently a bug either.

Acked-by: Arnd Bergmann <arnd@arndb.de>
