From: alex.shi@linaro.org (Alex Shi)
Date: Mon, 09 Dec 2013 21:40:22 +0800
Subject: questions of cpuidle
Message-ID: <52A5C846.30308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Sorry for a idiot of cpuidle.

I just find few cpu set TIMER_STOP on cpuidle, like omap4 and big.Little
driver. Does that mean other ARM cpu or x86 cpu can get the timer
interrupt in cpuidle?

If the timer stopped during cpuidle, does that means at least one cpu
cann't get into deep c-state since system need a cpu to wake up other
deep c-state cpu? Or sth I missed?

If the cpu stopped the interrupt during deep c-state and without
monitor/mwait support, which kind of ipi can wake the cpu? I mean like a
x86 cpu, APIC stopped in c3 mode, but actually ipi send via apic bus. So
I don't know which ipi work?

-- 
Thanks
    Alex
