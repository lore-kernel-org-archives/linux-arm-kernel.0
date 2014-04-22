From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 22 Apr 2014 13:59:43 -0400 (EDT)
Subject: [PATCH] usb: ohci-exynos: Add facility to use phy provided by
 the generic phy framework
In-Reply-To: <CAFp+6iGrgMTE27FxpFTQfALJO_XypxGSZ1-wny8KAoY1sLBbWw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1404221358530.1326-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Apr 2014, Vivek Gautam wrote:

> On Thu, Apr 10, 2014 at 6:54 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> > Add support to consume phy provided by Generic phy framework.
> > Keeping the support for older usb-phy intact right now, in order
> > to prevent any functionality break in absence of relevant
> > device tree side change for ohci-exynos.
> > Once we move to new phy in the device nodes for ohci, we can
> > remove the support for older phys.
> 
> Any comments on this please.
> I think whatever the approach we follow, that can be common to both
> ehci-exynos[1], and ohci-exynos, since
> both are needed to move to the new generic phy framework, keeping
> support for older usb-phy
> so as to have smooth transition, in order to avoid any regression.

I lost my copies of the ehci-exynos patch, but probably the same 
comments apply as for the ohci-exynos patch.

Alan Stern
