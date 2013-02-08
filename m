From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 Feb 2013 18:32:24 +0000 (UTC)
Subject: OMAP baseline test results for v3.8-rc6
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC071DC@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1302062333270.12769@utopia.booyaka.com>
 <20130207083217.GA15462@arwen.pp.htv.fi>
 <79CD15C6BA57404B839C016229A409A83EC06CEA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302081306230.11464@utopia.booyaka.com>
 <alpine.DEB.2.00.1302081332200.11464@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EC071DC@DBDE01.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1302081830310.28008@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


By the way, here's what I used for v3.7-rc8, which seemed to work okay:

http://www.pwsan.com/omap/testlogs/test_v3.7-rc8/20121204220128/build/am33xx_only/

and here's the boot log:

http://www.pwsan.com/omap/testlogs/test_v3.7-rc8/20121204220128/boot/am335xbone/am335xbone_log.txt

Note of course that there are some Kconfig changes between v3.7-rc8 and 
v3.8-rcX, so it's possible that the problem could be in those changes, of 
course.


- Paul
