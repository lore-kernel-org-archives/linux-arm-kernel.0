From: oleksandrs@mellanox.com (Oleksandr Shamray)
Date: Thu, 30 Nov 2017 10:49:27 +0000
Subject: [patch v12 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <CAOFm3uHg8n4A8opaOC3=pNtM1yJU6iy5Ta8XtGOvqT-Euv=X1w@mail.gmail.com>
References: <1510675867-24276-1-git-send-email-oleksandrs@mellanox.com>
 <1510675867-24276-3-git-send-email-oleksandrs@mellanox.com>
 <CAGMNF6XRwU5QEJhkg-mVwE5zpPigtcGJtRUupZHtcWRdedcsxg@mail.gmail.com>
 <CAOFm3uHg8n4A8opaOC3=pNtM1yJU6iy5Ta8XtGOvqT-Euv=X1w@mail.gmail.com>
Message-ID: <AM4PR0501MB2194FDF093DD241694BE77BFB1380@AM4PR0501MB2194.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thnaks for point 

Best Regards,
Oleksandr Shamray

> -----Original Message-----
> From: Philippe Ombredanne [mailto:pombredanne at nexb.com]
> Sent: Thursday, November 30, 2017 10:21 AM
> To: Kun Yi <kunyi@google.com>
> Cc: Oleksandr Shamray <oleksandrs@mellanox.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; arnd at arndb.de; system-sw-low-level <system-
> sw-low-level at mellanox.com>; devicetree at vger.kernel.org; jiri at resnulli.us;
> Vadim Pasternak <vadimp@mellanox.com>; linux-api at vger.kernel.org;
> OpenBMC Maillist <openbmc@lists.ozlabs.org>; LKML <linux-
> kernel at vger.kernel.org>; openocd-devel-owner at lists.sourceforge.net;
> mec at shout.net; Jiri Pirko <jiri@mellanox.com>; robh+dt at kernel.org; linux-
> serial at vger.kernel.org; tklauser at distanz.ch; Mauro Carvalho Chehab
> <mchehab@kernel.org>; David S. Miller <davem@davemloft.net>; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [patch v12 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
> families JTAG master driver
> 
> On Wed, Nov 29, 2017 at 11:51 PM, Kun Yi <kunyi@google.com> wrote:
> > On Tue, Nov 14, 2017 at 8:11 AM, Oleksandr Shamray
> > <oleksandrs@mellanox.com> wrote:
> []
> >> diff --git a/drivers/jtag/jtag-aspeed.c b/drivers/jtag/jtag-aspeed.c
> >> new file mode 100644 index 0000000..a6e2417
> >> --- /dev/null
> >> +++ b/drivers/jtag/jtag-aspeed.c
> >> @@ -0,0 +1,782 @@
> >> +/*
> >> + * drivers/jtag/aspeed-jtag.c
> >> + *
> >> + * Copyright (c) 2017 Mellanox Technologies. All rights reserved.
> >> + * Copyright (c) 2017 Oleksandr Shamray <oleksandrs@mellanox.com>
> >> + *
> >> + * Released under the GPLv2 only.
> >> + * SPDX-License-Identifier: GPL-2.0
> >> + */
> 
> I think the SPDX id should be on the first line as requested by Linus and
> documented by Thomas (tglx) and Greg (greg-kh). And it should use //
> comments, e.g:
> 
> // SPDX-License-Identifier: GPL-2.0
> 
> See the threads discussing all these.
> 
> 
> --
> Cordially
> Philippe Ombredanne
