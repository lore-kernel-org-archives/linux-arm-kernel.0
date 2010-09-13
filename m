From: gadiyar@ti.com (Gadiyar, Anand)
Date: Mon, 13 Sep 2010 22:46:38 +0530
Subject: Common warnings
In-Reply-To: <20100913164905.GC12197@kyllikki.org>
References: <20100913164905.GC12197@kyllikki.org>
Message-ID: <AANLkTinoneeu5a5jhYfDZpKb-6dzKUwvWKnD=6UA=WUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 10:19 PM, Vincent Sanders <vince@kyllikki.org> wrote:
> The number or warnings common to numerous builds has been rising
> recently. Perhaps some maintainers would care to address these issues
> before we become the most noisy kernel build target (currently MIPS).
>

...

> 39/156 builds have:
>
> ?arch/arm/plat-omap/include/plat/usb.h:109: warning: return type defaults to 'int'
>

This one should be fixed by a patch I posted [1]. Will go ping Tony to
see if he'll pick it up - I can't seem to locate it in patchwork
though.

- Anand

[1] http://marc.info/?l=linux-omap&m=128212353619711&w=2
