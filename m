From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 16:46:16 +0100
Subject: [PATCH] ARM: defconfig: imx_v6_v7_defconfig updates
In-Reply-To: <20141130145447.GA2411@dragon>
References: <1416614103-21237-1-git-send-email-shawn.guo@linaro.org>
 <20141130145447.GA2411@dragon>
Message-ID: <3685070.EAgBTWZY1G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 30 November 2014 22:54:51 Shawn Guo wrote:
> Hi Arnd, Olof,
> 
> On Sat, Nov 22, 2014 at 07:55:03AM +0800, Shawn Guo wrote:
> > From: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
> > 
> > This is a squash of several imx_v6_v7_defconfig update patches.
> > 
> >  - Enable tlv320aic3x audio codec by default (Phytec PBAB01 board)
> >  - Enable DS1307 rtc and gpio fan by default (TBS2910 board)
> >  - Select thermal related drivers
> >  - Add SNVS power off driver
> > 
> > Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
> > Signed-off-by: Soeren Moch <smoch@web.de>
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > Signed-off-by: Robin Gong <b38343@freescale.com>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> I haven't found this patch on arm-soc next/defconfig branch.  Can you
> please apply it?  Thanks.
> 

Applied now, thanks for the reminder!

	Arnd
