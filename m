From: balbi@ti.com (Felipe Balbi)
Date: Wed, 5 Sep 2012 15:52:11 +0300
Subject: [PATCH v2] usb: move phy driver from mach-tegra to drivers/usb
In-Reply-To: <D958900912E20642BCBC71664EFECE3E6DDE77533D@BGMAIL02.nvidia.com>
References: <1346395526-18219-1-git-send-email-vbyravarasu@nvidia.com>
 <5046772F.6060908@wwwdotorg.org>
 <D958900912E20642BCBC71664EFECE3E6DDE77533D@BGMAIL02.nvidia.com>
Message-ID: <20120905125210.GG19591@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 05, 2012 at 06:24:13PM +0530, Venu Byravarasu wrote:
> 
> > -----Original Message-----
> > From: Stephen Warren [mailto:swarren at wwwdotorg.org]
> > Sent: Wednesday, September 05, 2012 3:19 AM
> > To: balbi at ti.com
> > Cc: Venu Byravarasu; ccross at android.com; olof at lixom.net;
> > linux at arm.linux.org.uk; stern at rowland.harvard.edu;
> > gregkh at linuxfoundation.org; linux-kernel at vger.kernel.org; linux-
> > tegra at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> > usb at vger.kernel.org
> > Subject: Re: [PATCH v2] usb: move phy driver from mach-tegra to drivers/usb
> > 
> > On 08/31/2012 12:45 AM, Venu Byravarasu wrote:
> > > As part of this patch:
> > > 	1. Moved existing tegra phy driver to drivers/USB directory.
> > > 	2. Added standard USB phy driver APIs to tegra phy driver.
> > >
> > > Signed-off-by: Venu Byravarasu <vbyravarasu@nvidia.com>
> > 
> > Tested-by: Stephen Warren <swarren@nvidia.com>
> > 
> > Felipe, Would it be possible to apply this patch to a topic branch, so
> > that I can merge it into the Tegra tree? The reason is that I'd like to
> > remove Tegra's devices.[ch] in kernel 3.7, but to do that, I need to
> > move a tiny chunk of code out of that file somewhere else, and doing
> > that relies on adding a #include to usb_phy.h/tegra_usb_phy.h, which is
> > renamed in this patch.
> > 
> > Alternatively, if you don't think it'll cause any merge conflicts with
> > the USB PHY tree, I can just take this patch through the Tegra tree if
> > you want. Venu, do you plan any other patches within the next couple
> > weeks or so (i.e. before 3.6-rc6) that will depend on this patch? If so,
> > taking it only through the Tegra tree might not work so well.
> 
> Thanks Stephen for verifying the changes.
> I'm planning to push next patches, with tegra3 phy support added, very soon.  

Unfortunately the patch didn't apply on my xceiv branch. Could you
rebase on top of that ?

thanks a lot

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120905/20d05f2a/attachment-0001.sig>
