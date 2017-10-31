From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Oct 2017 21:50:19 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <nycvar.YSQ.7.76.1710311527280.21665@knanqh.ubzr>
References: <80bc8c16-321a-43ea-6cbb-257dbeee485b@arm.com>
 <nycvar.YSQ.7.76.1710311302370.21665@knanqh.ubzr>
 <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
 <20171031175344.GJ9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311355000.21665@knanqh.ubzr>
 <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1710311527280.21665@knanqh.ubzr>
Message-ID: <20171031215018.GL9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 03:28:11PM -0400, Nicolas Pitre wrote:
> On Tue, 31 Oct 2017, Chris Brandt wrote:
> > This patch worked for me.
> > I get my carriage returns again.
> 
> Good!  Queued as patch #8717.

I was going to say that there's another implementation of the
same in arch/arm/boot/compressed/head.S, and if we fix one we
should apply the same fix to the other.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
