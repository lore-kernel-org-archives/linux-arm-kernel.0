From: rogerq@ti.com (Roger Quadros)
Date: Fri, 1 Feb 2013 16:31:38 +0200
Subject: [PATCH v2 00/30] USB: omap-ehci: Move PHY management to PHY driver
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA9FFD5@DBDE01.ent.ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA95DF0@DBDE01.ent.ti.com>
 <510916B2.7080509@ti.com> <20130130131504.GU15258@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA95E97@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9FF9C@DBDE01.ent.ti.com>
 <510BD04A.4000909@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9FFD5@DBDE01.ent.ti.com>
Message-ID: <510BD1CA.9020309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2013 04:27 PM, Mohammed, Afzal wrote:
> Hi Roger,
> 
> On Fri, Feb 01, 2013 at 19:55:14, Quadros, Roger wrote:
> 
>> Thanks Afzal :). You mean the non device tree boot right?
> 
> No, dt boot, am335x can only dt boot.

but DT boot is not supported for OMAP USB Host. How did you get it to work?

Are you testing the Host connector or the OTG connector?

regards,
-roger
