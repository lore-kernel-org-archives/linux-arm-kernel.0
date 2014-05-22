From: shabbirkhank@gmail.com (shabbir)
Date: Thu, 22 May 2014 05:00:32 +0000 (UTC)
Subject: Facing issue with testing SP805 WDT timer
Message-ID: <loom.20140522T064647-619@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I tried to run the WDT Linux application present in
Documentation/watchdog/src/watchdog-test.c on our ARM cortex-A9 based board.
But we are coming up with following problem, as reset is not triggering:
zynq> ./watchdog-test -e
Watchdog card enabled.
Watchdog watchdog0: watchdog did not stop!
zynq> ./watchdog-test 
Watchdog Ticking Away!

Then hanging there forever.


Please Let me know how to test ARM SP805 driver at linux level, i tested on
U-boot, reset works fine.







Best Regards
Shabbir
 
