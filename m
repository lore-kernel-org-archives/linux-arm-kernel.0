From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 06 Mar 2014 10:33:16 +0100
Subject: [PATCH v2 1/6] ARM: dts: tegra: add PCIe interrupt mapping
 properties
In-Reply-To: <53179D5D.4070303@wwwdotorg.org>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-2-git-send-email-l.stach@pengutronix.de>
 <53179D5D.4070303@wwwdotorg.org>
Message-ID: <1394098396.4535.1.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 05.03.2014, 14:55 -0700 schrieb Stephen Warren:
> On 03/05/2014 06:25 AM, Lucas Stach wrote:
> > Those are defined by the common PCI binding.
> 
> It sounds like there's no dependency between pathces 1/6 and 2/6, so I
> should apply 1/6 to the Tegra tree, and Bjorn apply 2/6 to the PCI tree?

Right, that's why I split the patches between driver and DT changes. As
this change should be fully backward compatible to old DTs there
shouldn't be any harm.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
