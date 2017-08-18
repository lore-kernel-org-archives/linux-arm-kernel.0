From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 18 Aug 2017 09:30:22 +0800
Subject: [PATCH] ARM: dts: imx6qdl-nitrogen6_som2: fix PCIe reset
In-Reply-To: <20170817150236.GA8358@kroah.com>
References: <20170817135010.3042-1-gary.bisson@boundarydevices.com>
 <20170817150236.GA8358@kroah.com>
Message-ID: <20170818013020.GH7608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 08:02:36AM -0700, Greg KH wrote:
> On Thu, Aug 17, 2017 at 03:50:10PM +0200, Gary Bisson wrote:
> > Previous value was a bad copy of nitrogen6_max device tree.
> > 
> > Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

I didn't realized that Gary wants to get this into stable.  I will add
Fixes and stable tags to the patch.  Thanks, Greg.

Shawn
