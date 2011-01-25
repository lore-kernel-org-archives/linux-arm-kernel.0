From: ierton@gmail.com (Sergey Mironov)
Date: Tue, 25 Jan 2011 15:21:12 +0300
Subject: timer_tick vs clockevent
Message-ID: <AANLkTikfhObABzCcq4gMYaTQ+i2UdVN-xS+XDWc8kZw2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi. I am working on porting linux to ARM 1176-based SoC. My quiestion
is about system time. I see 2 ways of implementing it: 1) Define
struct sys_timer variable and call timer_tick() from timer's interrupt
handler 2) Use clocksource/clockevents. Looks like 2nd way is more
elaborate, but what will I get if choose it?

Thanks, Sergey
