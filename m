From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 8 Jul 2014 14:36:37 +0200
Subject: [PATCH v9 1/7] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <53BBE419.8080107@ti.com>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com>
 <1404728173-20263-2-git-send-email-antoine.tenart@free-electrons.com>
 <53BBE419.8080107@ti.com>
Message-ID: <20140708123637.GA5330@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 08, 2014 at 05:59:13PM +0530, Kishon Vijay Abraham I wrote:
> Hi Antoine,
> 
> On Monday 07 July 2014 03:46 PM, Antoine T?nart wrote:
> > The Berlin SoC has a two SATA ports. Add a PHY driver to handle them.
> > 
> > The mode selection can let us think this PHY can be configured to fit
> > other purposes. But there are reasons to think the SATA mode will be
> > the only one usable: the PHY registers are only accessible indirectly
> > through two registers in the SATA range, the PHY seems to be integrated
> > and no information tells us the contrary. For these reasons, make the
> > driver a SATA PHY driver.
> 
> Thanks for doing multiple revisions of this. Looks good to be merged for me now.

Great!

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
