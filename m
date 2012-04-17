From: marex@denx.de (Marek Vasut)
Date: Tue, 17 Apr 2012 22:10:42 +0200
Subject: [PATCH] i.MX28: Shut down the LCD controller to avoid bootrom
 sampling bug
In-Reply-To: <4F8D8FF9.9040909@mvista.com>
References: <1334675261-31570-1-git-send-email-marex@denx.de>
 <4F8D8FF9.9040909@mvista.com>
Message-ID: <201204172210.42616.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sergei Shtylyov,

> Hello.
> 
> On 04/17/2012 07:07 PM, Marek Vasut wrote:
> > From: Marek Vasut<marek.vasut@gmail.com>
> > 
> > Signed-off-by: Marek Vasut<marek.vasut@gmail.com>
> > Cc: Chen Peter-B29397<B29397@freescale.com>
> > Cc: Detlev Zundel<dzu@denx.de>
> > Cc: Fabio Estevam<festevam@gmail.com>
> > Cc: Li Frank-B20596<B20596@freescale.com>
> > Cc: Lin Tony-B19295<B19295@freescale.com>
> > Cc: Linux USB<linux-usb@vger.kernel.org>
> > Cc: Sascha Hauer<s.hauer@pengutronix.de>
> > Cc: Shawn Guo<shawn.guo@freescale.com>
> > Cc: Shawn Guo<shawn.guo@linaro.org>
> > Cc: Stefano Babic<sbabic@denx.de>
> > Cc: Subodh Nijsure<snijsure@grid-net.com>
> > Cc: Tony Lin<tony.lin@freescale.com>
> > Cc: Wolfgang Denk<wd@denx.de>
> > ---
> > 
> >   drivers/video/mxsfb.c |   13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> 
>     Why post this to linux-usb?

Copy-paste mistake

> 
> WBR, Sergei

Best regards,
Marek Vasut
