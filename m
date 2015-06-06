From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sat,  6 Jun 2015 05:57:22 +0200
Subject: ARM:Gemini:fix/update timer clocksource
Message-ID: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixexs this and do some cosmetic cleanup in the clocksource 
driver for mach-gemini.

timer1 is used for clockevent
timer3 for free running timer, scheduler clock source.

The work is based on a patch found on openwrt.org in
target/linux/gemini/patches-3.18/160-gemini-timers.patch

Hans Ulli
