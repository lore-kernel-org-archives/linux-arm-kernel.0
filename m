From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Nov 2011 11:40:49 +0100
Subject: [03: PATCH 0/5] The remaining stuff
In-Reply-To: <20111111171650.GA4154@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <20111106173939.GJ12913@n2100.arm.linux.org.uk>
 <20111106175457.GK12913@n2100.arm.linux.org.uk>
 <20111111171650.GA4154@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdb4ozt1S3CrEeWGY5zeeJ-=vi8Wh18jv9AONRAH+W1MxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 6:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> The list of platforms which are still broken (today) by part 2 of this
> series are:
>
(...)
> arch/arm/mach-nomadik/include/mach/system.h
(...)
>
> which require assistance to get these into shape.

Is this about the problem of where to place the hook
for restart as described in this message?
http://marc.info/?l=linux-arm-kernel&m=132104005724249&w=2

If you apply that patch I think it's easy to fix that up,
if you have some git branch I can base off I can fix
it up too.

Or you can just throw it into -next so it breaks and I'll fix
from there ASAP, no big deal.

Thanks,
Linus Walleij
