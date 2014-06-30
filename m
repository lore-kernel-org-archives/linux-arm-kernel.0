From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 30 Jun 2014 12:20:14 +0200
Subject: [PATCH v6 1/7] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <53A96A1C.5030800@gmail.com>
References: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com>
 <1402914392-6028-2-git-send-email-antoine.tenart@free-electrons.com>
 <53A9685E.9090501@ti.com> <53A96A1C.5030800@gmail.com>
Message-ID: <20140630102014.GA5155@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jun 24, 2014 at 05:37:56PM +0530, Varka Bhadram wrote:
> On 06/24/2014 05:30 PM, Kishon Vijay Abraham I wrote:
> >On Monday 16 June 2014 03:56 PM, Antoine T?nart wrote:
> >>+
> >>+static struct phy *phy_berlin_sata_phy_xlate(struct device *dev,
> >>+					     struct of_phandle_args *args)
> 
> Indent the function properly like this:
> static struct phy *phy_berlin_sata_phy_xlate(struct device *dev,
> 					     struct of_phandle_args *args)
> 
> check with checkpatch.pl script

Already fixed in v7.


Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
