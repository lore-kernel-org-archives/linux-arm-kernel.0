From: bill_carson@126.com (bill)
Date: Wed, 20 Apr 2011 10:07:52 +0800 (CST)
Subject: Query about vexpress_ct_ca9x4 watchdog issue ?
Message-ID: <1b4f89d.afd2.12f70a9e2b0.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi viresh and arm guys:)

I am testing sp805 watchdog at vexpress board.

After open /dev/watchdog , I use WDIOC_GETTIMELEFT ioctl to get the time left for rebooting in a loop;
while the timeleft is not decrementing, but stay as a constant 59s.

I read the WdogValue/WdogControl register as specified in SP805TRM, it does not change any way, 

WdogValue     --> 0xf0918000
WdogControl   -->0x3


It seems the value is correct, but watchdog is not triggered.
I am really puzzled about this, can you give me some clue to find the root cause?


thanks


bill
