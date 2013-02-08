From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 8 Feb 2013 18:25:18 +0000
Subject: OMAP baseline test results for v3.8-rc6
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com>
 <20130207083217.GA15462@arwen.pp.htv.fi>
 <79CD15C6BA57404B839C016229A409A83EC06CEA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302081306230.11464@utopia.booyaka.com>
 <alpine.DEB.2.00.1302081332200.11464@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC071DC@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 20:40:22, Hiremath, Vaibhav wrote:
> On Fri, Feb 08, 2013 at 19:04:04, Paul Walmsley wrote:
> > On Fri, 8 Feb 2013, Paul Walmsley wrote:
> > 
> > > The point is to try to minimize bootloader dependencies.
> > 
> > Also if there are weird bootloader dependendencies that no one can track 
> > down, we should document them somewhere, maybe underneath 
> > Documentation/arm/OMAP.
> > 
> 



Paul,

Have you enabled below options in your defconfig,

CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y


I am sure you must have already enabled it, but still would like to clarify 
Here.

Thanks,
Vaibhav
