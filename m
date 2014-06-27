From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Fri, 27 Jun 2014 18:05:57 +0200
Subject: [PATCH v2 05/12] usb: phy: add the Berlin USB PHY driver
In-Reply-To: <20140627155622.GL8069@saruman.home>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403606121-6368-6-git-send-email-antoine.tenart@free-electrons.com>
 <20140627155622.GL8069@saruman.home>
Message-ID: <20140627160557.GA6622@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Fri, Jun 27, 2014 at 10:56:22AM -0500, Felipe Balbi wrote:
> On Tue, Jun 24, 2014 at 12:35:14PM +0200, Antoine T?nart wrote:
> > Add the driver driving the Marvell Berlin USB PHY. This allows to
> > initialize the PHY and to use it from the USB driver later.
> > 
> > Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> 
> since this is a brand new driver, it should go to drivers/phy instead.

This PHY is used by a ChipIdea USB driver, which uses the provided
common function for ChipIdea. These functions use the usb_phy framework.
That's why this PHY driver is there.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
