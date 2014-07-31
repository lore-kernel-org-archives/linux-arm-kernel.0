From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Thu, 31 Jul 2014 13:32:18 +0200
Subject: [PATCH 2/5] arm64, thunder: Add initial dts for Cavium Thunder SoC
In-Reply-To: <CAL_JsqLJ_W34XTF2aMOW9z+Gq4oxbrX1RztyJN8Mi0OFPeNxfg@mail.gmail.com>
References: <1406732794-20920-1-git-send-email-rric@kernel.org>
 <1406732794-20920-3-git-send-email-rric@kernel.org>
 <20140730154626.GD20162@leverpostej>
 <CAL_JsqLJ_W34XTF2aMOW9z+Gq4oxbrX1RztyJN8Mi0OFPeNxfg@mail.gmail.com>
Message-ID: <20140731113218.GQ4703@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob and Arnd,

On 30.07.14 11:37:38, Rob Herring wrote:
> >> +/*
> >> + * Cavium Thunder DTS file
> >> + *
> >> + * Copyright (C) 2013, Cavium Inc.
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> + * modify it under the terms of the GNU General Public License as
> >> + * published by the Free Software Foundation; either version 2 of
> >> + * the License, or (at your option) any later version.
> >> + */
> 
> You may want to reconsider if this should be BSD.

I understand that this is an issue for the inclusion in firmware
binaries. Though, we just followed common practice here which is
gplv2.

I looked through existing dts files in arch/arm*/dts/* and about 590
of 720 have a gplv2 statement in. The other files don't have any and
thus following the COPYING file which is gplv2 too.                 

It is my understanding that the kernel requires licensing under gplv2.
So an option would be to dual license the dts file, e.g. with BSD. How
is this typically handled? Are there other repositories where dts
files are included with a different license model than gplv2?

Thanks,

-Robert
