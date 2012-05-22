From: linuxzsc@gmail.com (Richard Zhao)
Date: Tue, 22 May 2012 23:30:04 +0800
Subject: [PATCH v2 05/12] usb: chipidea: add imx driver binding
In-Reply-To: <878vgkbjie.fsf@ashishki-desk.ger.corp.intel.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-6-git-send-email-richard.zhao@freescale.com>
 <87bolgbjnr.fsf@ashishki-desk.ger.corp.intel.com>
 <878vgkbjie.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20120522153003.GD2380@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 01:24:57PM +0300, Alexander Shishkin wrote:
> Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:
> 
> > Richard Zhao <richard.zhao@freescale.com> writes:
> >
> >> +#include "ci.h"
> >> +
> >> +#define PORT0_STATUS	0x184
> >
> > This doesn't seem to be used anywhere.
> 
> Please disregard this one.
Thanks.

Richard
> 
> Regards,
> --
> Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
