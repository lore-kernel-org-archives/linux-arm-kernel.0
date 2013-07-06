From: r65037@freescale.com (Zhu Richard-R65037)
Date: Sat, 6 Jul 2013 01:55:19 +0000
Subject: [v3 3/3] sata: imx: add ahci sata support on imx platforms
In-Reply-To: <1373040406.217809169@f299.mail.ru>
References: <1373017942-12583-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373017942-12583-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130705155911.GK516@pengutronix.de>,<1373040406.217809169@f299.mail.ru>
Message-ID: <0E83723C55F66F43A6041464FE31119D31430A@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander:
Thanks for your comments.

Best Regards
Richard Zhu
________________________________________
From: Alexander Shiyan [shc_work at mail.ru]
Sent: Saturday, July 06, 2013 12:06 AM
To: Sascha Hauer
Cc: Richard Zhu; Zhu Richard-R65037; shawn.guo at linaro.org; rob.herring at calxeda.com; linux-ide at vger.kernel.org; avorontsov at ru.mvista.com; jgarzik at pobox.com; linux-arm-kernel at lists.infradead.org
Subject: Re[2]: [v3 3/3] sata: imx: add ahci sata support on imx platforms

> On Fri, Jul 05, 2013 at 05:52:22PM +0800, Richard Zhu wrote:
> > From: Richard Zhu <r65037@freescale.com>
...
> > +   if (!(ret & HOST_CAP_SSS))
> > +           writel(ret |= HOST_CAP_SSS, mmio + HOST_CAP);
>
> Why do you write this conditionally? Just write it unconditionally.

"writel" with assignment is incorrect in any case.
[Richard] would be fixed later.

---
