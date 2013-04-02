From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Apr 2013 15:44:07 +0300
Subject: [PATCH 1/2] ARM: imx_v6_v7_defconfig: add CONFIG_USB_PHY
In-Reply-To: <20130402111245.GC24039@S2101-09.ap.freescale.net>
References: <1364133966-22373-1-git-send-email-shawn.guo@linaro.org>
 <20130402080706.GC30286@arwen.pp.htv.fi>
 <20130402111245.GC24039@S2101-09.ap.freescale.net>
Message-ID: <20130402124407.GE9488@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 02, 2013 at 07:12:47PM +0800, Shawn Guo wrote:
> On Tue, Apr 02, 2013 at 11:07:06AM +0300, Felipe Balbi wrote:
> > On Sun, Mar 24, 2013 at 10:06:04PM +0800, Shawn Guo wrote:
> > > Commit edc7cb2 (usb: phy: make it a menuconfig) makes USB_MXS_PHY
> > > be a sub-item of menuconfig symbol USB_PHY.  This change gets the
> > > selection of CONFIG_USB_MXS_PHY in imx_v6_v7_defconfig lost.  Hence the
> > > boot stops at the point below.
> > > 
> > >   ci_hdrc ci_hdrc.0: doesn't support gadget
> > >   ci_hdrc ci_hdrc.0: EHCI Host Controller
> > >   ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 1
> > > 
> > > Add CONFIG_USB_PHY to have the CONFIG_USB_MXS_PHY selection back to
> > > work.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > 
> > should I take this or will Russell queue it during -rc ?
> 
> Though I can send it via arm-soc tree when your patches land on
> mainline, I think the easier way is that you take both patches via
> your tree.

alright, in that case can you rebase on next branch ? patch 2 didn't
apply.

thank you

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130402/b81cf143/attachment.sig>
