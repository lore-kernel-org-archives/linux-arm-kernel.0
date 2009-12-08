From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 Dec 2009 14:26:40 +0100
Subject: [CFT:PATCH] Remove a seemingly unnecessary cache flush
In-Reply-To: <20091207203258.GH26821@n2100.arm.linux.org.uk>
References: <20091207203258.GH26821@n2100.arm.linux.org.uk>
Message-ID: <20091208132640.GA12336@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

my machine works fine with your patch.  Tested booting + hackbench.

Best regards
Uwe

root at phyCORE:~ cat /proc/cpuinfo 
Processor	: ARM926EJ-S rev 4 (v5l)
BogoMIPS	: 199.06
Features	: swp half thumb fastmult edsp java 
CPU implementer	: 0x41
CPU architecture: 5TEJ
CPU variant	: 0x0
CPU part	: 0x926
CPU revision	: 4

Hardware	: phyCORE-i.MX27
Revision	: 0000
Serial		: 0000000000000000


-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
