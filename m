From: alex.shi@linaro.org (Alex Shi)
Date: Tue, 04 Feb 2014 00:17:30 +0800
Subject: a LLC sched domain bug for panda board?
Message-ID: <52EFC11A.8010709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I just run the 3.14-rc1 kernel on panda board. The only domain for it is
'CPU' domain, but this domain has no SD_SHARE_PKG_RESOURCES setting, it
has no sd_llc.

Guess the right domain for this board should be MC. So is it a bug?

..
/proc/sys/kernel/sched_domain/cpu0/domain0/name:CPU
..
/proc/sys/kernel/sched_domain/cpu1/domain0/name:CPU

-- 
Thanks
    Alex
