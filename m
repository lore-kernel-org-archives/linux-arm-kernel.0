From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 6 Oct 2011 13:36:21 +0200
Subject: sched: ARM: arch_scale_freq_power
Message-ID: <CAKfTPtB3sLWq5fHOTrFg6vfHSKnz2i17oYx9Btr0u_tWV2bsjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I work to link the cpu_power of ARM cores to their frequency by using
arch_scale_freq_power. It's explained in the kernel that cpu_power is
used to distribute load on cpus and a cpu with more cpu_power will
pick up more load. The default value is SCHED_POWER_SCALE and I
increase the value if I want a cpu to have more load than another one.
Is there an advised range for cpu_power value as well as some time
scale constraints for updating the cpu_power value ?
I'm also wondering why this scheduler feature is currently disable by default ?

Regards,
Vincent
