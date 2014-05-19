From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 May 2014 16:30:48 +0800
Subject: [PATCH 3/4] ARM: imx: remove imx51 non-DT support files
In-Reply-To: <1400486772.124660835@f325.i.mail.ru>
References: <1400482606-8278-1-git-send-email-shawn.guo@freescale.com>
 <1400482606-8278-4-git-send-email-shawn.guo@freescale.com>
 <1400486772.124660835@f325.i.mail.ru>
Message-ID: <20140519083047.GM10685@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 12:06:12PM +0400, Alexander Shiyan wrote:
> Mon, 19 May 2014 14:56:45 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> > Since i.MX51 becomes a DT only platform, those non-DT support files can
> > be removed now.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  arch/arm/mach-imx/Makefile        |   2 +-
> >  arch/arm/mach-imx/devices-imx51.h |  66 ---
> >  arch/arm/mach-imx/ehci-imx5.c     | 171 --------
> >  arch/arm/mach-imx/iomux-mx51.h    | 827 --------------------------------------
> >  4 files changed, 1 insertion(+), 1065 deletions(-)
> >  delete mode 100644 arch/arm/mach-imx/devices-imx51.h
> >  delete mode 100644 arch/arm/mach-imx/ehci-imx5.c
> >  delete mode 100644 arch/arm/mach-imx/iomux-mx51.h
> 
> ...
> 
> > -int mx51_initialize_usb_hw(int port, unsigned int flags)
> 
> Additionally, we should not forget to remove mx51_initialize_usb_hw() declaration
> from include/linux/platform_data/usb-ehci-mxc.h in the future.

Yes.  I will resend to get this addressed.

Shawn
