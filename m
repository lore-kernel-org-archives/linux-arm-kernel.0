From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 1 Feb 2013 14:35:28 +0000
Subject: [PATCH v2 00/30] USB: omap-ehci: Move PHY management to PHY driver
In-Reply-To: <510BD1CA.9020309@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA95DF0@DBDE01.ent.ti.com>
 <510916B2.7080509@ti.com> <20130130131504.GU15258@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA95E97@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9FF9C@DBDE01.ent.ti.com>
 <510BD04A.4000909@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9FFD5@DBDE01.ent.ti.com>
 <510BD1CA.9020309@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EAA0011@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On Fri, Feb 01, 2013 at 20:01:38, Quadros, Roger wrote:

> but DT boot is not supported for OMAP USB Host. How did you get it to work?
> 
> Are you testing the Host connector or the OTG connector?

If you see latest changes on musb_dsps.c, you will be able to find
out.

As beagle bone first instance works only in device, it was tested
using ether gadget.

Regards
Afzal
