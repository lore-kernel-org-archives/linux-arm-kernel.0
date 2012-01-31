From: lost.distance@yahoo.com (Paul Parsons)
Date: Tue, 31 Jan 2012 17:28:10 +0000 (GMT)
Subject: reboot/suspend regression: hx4700 freezes under linux-3.3-rc1
Message-ID: <1328030890.46053.YahooMailClassic@web29001.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both reboot (via reboot(RB_AUTOBOOT)) and suspend (via apm --suspend) freeze my hx4700 under linux-3.3-rc1. They both worked under linux-3.2.

I presume that at least the reboot freeze is related to the restart changes back in November. Can anyone suggest anything obvious I should check? If not I'll attempt to get console output on to the screen, which may or may not help.
