From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Nov 2011 10:04:35 +0000
Subject: Inclusion of ARM perf tree in linux-next
Message-ID: <20111122100435.GC20518@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

I maintain the ARM perf backend and would be very grateful if you could
please include this branch in linux-next:

git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf

This request has arisen specifically from some work with the OMAP guys
where it would be useful to spot any conflicts for 3.3, however I think it's
generally a good idea for me to give some of the perf changes an airing
before they get merged anyway.

The merge path for these patches into mainline is usually via Russell, but
platform updates may go via arm-soc (Arnd).

Thanks,

Will
