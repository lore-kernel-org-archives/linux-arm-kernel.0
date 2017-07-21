From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 21 Jul 2017 13:37:41 -0300
Subject: IMX53 on recent 4.4.x kernels
In-Reply-To: <20170721163438.GG31807@n2100.armlinux.org.uk>
References: <D24E577EA1E37B4788A3BFBC418F14A707591D67@wetsrvex01.loepfe.com>
 <20170720123933.rioxhsthaaby4cnl@pengutronix.de>
 <D24E577EA1E37B4788A3BFBC418F14A707592381@wetsrvex01.loepfe.com>
 <CAOMZO5DrFnr6mr991ayMxLF0+jQddJyTbCbK1A5JVNAUVMDw3A@mail.gmail.com>
 <D24E577EA1E37B4788A3BFBC418F14A70759249B@wetsrvex01.loepfe.com>
 <20170720141528.kxrw5r4hpa2hebvd@pengutronix.de>
 <D24E577EA1E37B4788A3BFBC418F14A7075925A1@wetsrvex01.loepfe.com>
 <20170720235354.GF31807@n2100.armlinux.org.uk>
 <CAOMZO5Bot=XuByN2e4FsZi=T+ZNJv5aFtbfGtKFfASEoLQPvuA@mail.gmail.com>
 <20170721163438.GG31807@n2100.armlinux.org.uk>
Message-ID: <CAOMZO5CCp3S+YXOxU41DM6_uHWAGvyrrqEMdLubX+jAFyiky9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 1:34 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> Note - you want lockdep and so forth enabled for development kernels
> to catch bugs before changes are submitted upstream.  However, for
> kernels that you care about performance, you need to have them disabled.
>
> Like everything it's a balance between function and performance.

Yes, it makes sense. Thanks for the suggestion!
