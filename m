From: liu.h.jason@gmail.com (Jason Liu)
Date: Wed, 2 May 2012 15:16:49 +0800
Subject: About CPU hotplug stress test failed
Message-ID: <CAB4PhKf06wNA_=QEe3uT9u25WaxVHAenWADCA49hUwJxcPGdwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, kernel experts

 We met CPU hotplug issue on v3.0.15 and event the latest v3.4,
sometimes system hang when doing stress test of CPU hotplug which is
simply to remove all secondary cores(core1 ~ core3) and add them back,
the failure is in random. But we didn?t meet any issue on V2.6.38, so
I guess it is pure kernel issue, do you have any idea about it? Or did
you meet any similar issue on other platform(OMAP, SAMSUNG or Tegra)?
Thanks in advanced!


Jason Liu
