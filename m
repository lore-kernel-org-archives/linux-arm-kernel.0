From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 3 May 2017 16:03:12 +0200
Subject: [PATCH v3 2/3] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <6ed16e7e-7f7a-795f-ee82-d2d97c3a5540@arm.com>
References: <20170424075407.19730-1-antoine.tenart@free-electrons.com>
 <20170424075407.19730-3-antoine.tenart@free-electrons.com>
 <6ed16e7e-7f7a-795f-ee82-d2d97c3a5540@arm.com>
Message-ID: <20170503140312.civ5uxkksauhqfyp@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Wed, May 03, 2017 at 12:57:25PM +0100, Robin Murphy wrote:
> On 24/04/17 08:54, Antoine Tenart wrote:
> > +
> > +#include <asm/dma-mapping.h>
> 
> <linux/dma-mapping.h> everywhere, please.
> 
> Other than that, the DMA aspects all look much nicer now, thanks.

I'll update and resend a series when the next -rc1 is out.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170503/f1c7a8bc/attachment.sig>
