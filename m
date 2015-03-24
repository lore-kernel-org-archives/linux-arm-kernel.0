From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 24 Mar 2015 07:12:03 +0100
Subject: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
In-Reply-To: <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
 <20150323060706.GB4946@pengutronix.de>
 <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de>
Message-ID: <20150324061203.GO9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 06:54:34PM +0100, Stefan Wahren wrote:
> Hi Sascha,
> 
> > It is very unusual to describe the regulators of a device on a register
> > level like this and to iomemap each register individually. I think you
> > should drop the registers here and put this knowledge into the driver
> > like (nearly?) all others do.
> 
> do mean dropping the base address of the regulator, too?

Yes.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
