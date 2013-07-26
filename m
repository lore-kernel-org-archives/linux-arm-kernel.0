From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Fri, 26 Jul 2013 12:11:35 +0300
Subject: [PATCH 1/7] usb: phy: msm: Move mach dependent code to platform
 data
In-Reply-To: <20130724155505.GA26371@codeaurora.org>
References: <1372087664-26396-1-git-send-email-iivanov@mm-sol.com>
 <1372087664-26396-2-git-send-email-iivanov@mm-sol.com>
 <20130724155505.GA26371@codeaurora.org>
Message-ID: <1374829895.1956.39.camel@iivanov-dev.int.mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-07-24 at 08:55 -0700, David Brown wrote:
> On Mon, Jun 24, 2013 at 06:27:38PM +0300, Ivan T. Ivanov wrote:
> >From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> >
> >This patch fix compilation error and is an intermediate step
> >before the addition of DeviceTree support for newer targets.
> >Fix suggested here: https://lkml.org/lkml/2013/6/19/381
> >
> >Cc: David Brown <davidb@codeaurora.org>
> >Cc: Daniel Walker <dwalker@fifo99.com>
> >Cc: Bryan Huntsman <bryanh@codeaurora.org>
> >Cc: Russell King <linux@arm.linux.org.uk>
> >Cc: Felipe Balbi <balbi@ti.com>
> >Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >Cc: Stephen Boyd <sboyd@codeaurora.org>
> >Cc: linux-arm-kernel at lists.infradead.org
> >Cc: linux-kernel at vger.kernel.org
> >
> >Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> >---
> > arch/arm/mach-msm/board-msm7x30.c |   35 +++++++++++++++++++++++
> > arch/arm/mach-msm/board-qsd8x50.c |   34 +++++++++++++++++++++++
> > drivers/usb/phy/phy-msm-usb.c     |   55 ++++++++++---------------------------
> > include/linux/usb/msm_hsusb.h     |    2 ++
> > 4 files changed, 85 insertions(+), 41 deletions(-)
> 
> Acked-by: David Brown <davidb@codeaurora.org>
> 

Thank you David, but I am afraid that I have screwup this patch. It
doesn't build fine. I will send second version.
Sorry. Ivan
