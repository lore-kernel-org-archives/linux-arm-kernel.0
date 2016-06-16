From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Jun 2016 11:15:10 +0800
Subject: [PATCH 1/1] ARM: imx_v6_v7_defconfig: build in usbnet to support
 NFS for non-ethernet board
In-Reply-To: <CAL411-phKBkqu8hC72F3FGZMvrCZpPprXJf6CCt0m7gzAjpjsg@mail.gmail.com>
References: <1464937924-11683-1-git-send-email-peter.chen@nxp.com>
 <CAL411-phKBkqu8hC72F3FGZMvrCZpPprXJf6CCt0m7gzAjpjsg@mail.gmail.com>
Message-ID: <20160616031510.GB29560@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 10:40:14AM +0800, Peter Chen wrote:
> On Fri, Jun 3, 2016 at 3:12 PM, Peter Chen <peter.chen@nxp.com> wrote:
> > At some boards, it has no ethernet support. As an alternative, we can use
> > USB Ethernet card to support NFS (u-boot supports it too). It supports
> > AXIS cards which are used most frequently.
> >
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > ---
> >  arch/arm/configs/imx_v6_v7_defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> > index 21339ce..eaabae2 100644
> > --- a/arch/arm/configs/imx_v6_v7_defconfig
> > +++ b/arch/arm/configs/imx_v6_v7_defconfig
> > @@ -146,7 +146,7 @@ CONFIG_MICREL_PHY=y
> >  CONFIG_USB_PEGASUS=m
> >  CONFIG_USB_RTL8150=m
> >  CONFIG_USB_RTL8152=m
> > -CONFIG_USB_USBNET=m
> > +CONFIG_USB_USBNET=y
> >  CONFIG_USB_NET_CDC_EEM=m
> >  CONFIG_BRCMFMAC=m
> >  CONFIG_WL12XX=m
> > --
> 
> ping...

Applied.  Thanks for reminding.

Shawn
