From: ping.bai@nxp.com (Jacky Bai)
Date: Tue, 3 Jan 2017 01:00:52 +0000
Subject: [PATCH v2 06/12] driver: pinctrl: imx: Add pinctrl driver support
 for imx6sll
In-Reply-To: <CACRpkdZYH-X=SG7AfCOgKA9U0WL9941e-zo_tgUF74mdns2_7Q@mail.gmail.com>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-7-git-send-email-ping.bai@nxp.com>
 <CACRpkdZYH-X=SG7AfCOgKA9U0WL9941e-zo_tgUF74mdns2_7Q@mail.gmail.com>
Message-ID: <AM3PR04MB530275E01245160E8A441E5876E0@AM3PR04MB530.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v2 06/12] driver: pinctrl: imx: Add pinctrl driver support for
> imx6sll
> 
> On Tue, Dec 27, 2016 at 10:47 AM, Bai Ping <ping.bai@nxp.com> wrote:
> 
> > Add pinctrl driver support for imx6sll.
> >
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> (...)
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -514,6 +514,7 @@ config SOC_IMX6SL
> >
> >  config SOC_IMX6SLL
> >         bool "i.MX6 SoloLiteLite support"
> > +       select PINCTRL_IMX6SLL
> 
> This needs to be separate so I can merge the pure pin control patch to my tree.
> 
> Apart from that, look into using generic pinconf.
> 

Thanks for review, I will try to use generic pinconf


> Yours,
> Linus Walleij
