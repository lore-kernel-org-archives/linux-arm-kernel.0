From: shabbirkhank@gmail.com (shabbir)
Date: Mon, 27 Feb 2012 04:05:56 +0000 (UTC)
Subject: HR timer support
Message-ID: <loom.20120227T045339-27@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell
    I am working on ARM9 board whose clock is configured to operate at
milliseconds resolution,but i wanted to enable the High resolution timer support
in order the clock to operate in the order of microseconds,so i have enabled HR
timer support in make menuconfig and then recompiled the kernel and then i
checked cat /proc/timer_list in which the attribute .hres_active is still equals
to 0,but it should be 1.can you please suggest me how to implement HIGH
RESOLUTION timer support for my ARM hardware?I am using linux-2.6.28 kernel.


Thanks
Regards
Shabbir 
